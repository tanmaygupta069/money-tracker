# MoneyTrail — Flutter Architecture Implementation Plan

Implement **MoneyTrail** as an Android-only Flutter app using layered MVVM + repository architecture. Follow this document as the source of truth. Do not invent extra features.

**Workspace:** `d:\flutter\tanmaygupta069`  
**Flutter project path:** `d:\flutter\tanmaygupta069\money_trail` (create with `flutter create`)  
**Do not delete** `tracker/` — it is the Kotlin Room schema reference. Port the schema; do not run the Kotlin app.

**Product spec:** `tracker/claude.md`  
**Schema reference:** `tracker/data/**`

---

## 1. Product (v0)

Personal Android expense tracker. Tracks spend by reading bank SMS on one phone. Install via APK.

### Payment sources

| Source | How it appears |
|---|---|
| Kotak bank | Debit SMS (including GPay-from-Kotak) |
| Slice card | Slice debit SMS |
| GPay (manual) | No GPay SMS — manual entry only |
| Cash (manual) | Manual entry only |

### Locked decisions

- Android only. `minSdk 26`. No iOS, web, or desktop targets.
- SMS-based capture. No CSV/PDF import in v0.
- Two capture paths: (1) live `BroadcastReceiver` for `SMS_RECEIVED`, (2) inbox sync on app open / “Sync now”.
- First-run inbox window: last **60 days**. After that, messages newer than `lastSyncedAt`.
- Trusted senders only. Allowlist matches sender-ID **name** after stripping carrier prefix (`VM-KOTAKB`, `AX-KOTAKB-S` → treat as containing `KOTAK`). Start with `KOTAK` and `SLICE`, editable in Settings.
- Amounts stored as **integer paise**, never floats.
- Dedup: `sha256(rawBody + timestampMillis)`. Unique index. Manual entries have `messageHash = null` so dedup never applies to them.
- **No `INTERNET` permission.** `android:allowBackup="false"`. All data on-device.
- Credits/refunds: **skip in v0** (do not store as income).
- Charts: custom Flutter bars (`CustomPaint` or simple widgets). No chart package.
- GPay is not an auto-captured source.

### Screens

1. **Overview** — selected month total, split by Kotak / Slice / Manual, category breakdown, top merchants, month switcher.
2. **Transactions** — list with edit category, delete, add manual (GPay or Cash).
3. **Settings** — permission status, sender allowlist CRUD, “Sync now”, paste-an-SMS tester (parse only, do not persist).

---

## 2. Architecture rules (mandatory)

Enforce strict separation of concerns. **Never mix UI rendering with business logic or data fetching.**

### UI layer (MVVM)

- **Views:** lean widgets. Logic limited to layout, animation, routing. All data comes from the ViewModel. Use `ListenableBuilder` (or `AnimatedBuilder`).
- **ViewModels:** extend `ChangeNotifier`. Expose **immutable** state snapshots. Inject repositories / use cases via constructor. No Drift, no `MethodChannel`, no regex in ViewModels.

### Data layer

- **Services:** stateless wrappers around SQLite, SMS inbox, permissions, native queue. Return raw rows / DTOs / `Result`.
- **Repositories:** consume services, map to **domain models**, own caching and insert-ignore dedup. Single source of truth. ViewModels talk only to repositories (or use cases).

### Domain layer

Use cases **only** where logic is complex or reused across ViewModels:

| Use case | Why |
|---|---|
| `ParseSmsUseCase` | Regex pipeline; reused by inbox sync, queue drain, paste tester |
| `CategorizeMerchantUseCase` | Keyword rules with priority; used by parser and recategorize |
| `SyncInboxUseCase` | Cross-service: allowlist + inbox + parse + insert + sync state |

Skip use cases for simple CRUD (edit category, delete transaction, add/remove allowlist entry, add manual transaction).

### Dependency direction

```text
Views → ViewModels → UseCases → Repositories → Services
                         ↘ Repositories (CRUD)
```

Native Kotlin **must not** contain the Dart parser. Native code only: inbox query, `SMS_RECEIVED` receiver, raw queue writes, permission helpers.

### Stack

- Flutter (stable), Dart 3, Android only
- `drift` + `sqlite3` / `drift_flutter` for `moneytrail.db`
- `provider` for DI (`ChangeNotifierProvider` / `MultiProvider`)
- `freezed` + `json_annotation` **or** Dart 3 records/`==` immutable classes — prefer **`freezed`** for domain models
- `crypto` for sha256
- `permission_handler` **only if** it does not pull INTERNET; otherwise a tiny MethodChannel for SMS permission status/request
- Dev: `build_runner`, `drift_dev`, `freezed`, `flutter_lints`

Do **not** add Firebase, HTTP clients, analytics, or chart libraries.

---

## 3. Project creation

```bash
cd d:\flutter\tanmaygupta069
flutter create --org com.moneytrail --project-name money_trail --platforms android money_trail
```

Then:

- Set `minSdk` to **26** in `android/app/build.gradle.kts` (or `.gradle`).
- Application id: `com.moneytrail.app`
- Remove INTERNET if Flutter template added it (debug INTERNET for hot reload on some setups is a conflict with the privacy goal). For **release** manifest: no INTERNET. If the debug template requires INTERNET for tool observatory, put it in `src/debug/AndroidManifest.xml` only — never in main.
- Main `AndroidManifest.xml`: `android:allowBackup="false"`, permissions `READ_SMS`, `RECEIVE_SMS`. Register the `SmsReceivedReceiver` with `SMS_RECEIVED` (highest priority is not required; do not intercept/abort SMS).
- Kotlin namespace matching `com.moneytrail.app`.

---

## 4. Target tree

```text
money_trail/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── di.dart                          # MultiProvider wiring
│   ├── data/
│   │   ├── models/
│   │   │   ├── raw_sms.dart
│   │   │   └── parse_result.dart        # success / skip reason (data DTO ok)
│   │   ├── repositories/
│   │   │   ├── transaction_repository.dart
│   │   │   ├── category_rule_repository.dart
│   │   │   ├── sender_allowlist_repository.dart
│   │   │   └── sync_state_repository.dart
│   │   └── services/
│   │       ├── database/
│   │       │   ├── app_database.dart    # Drift
│   │       │   ├── tables.dart
│   │       │   └── database_service.dart
│   │       ├── sms_inbox_service.dart
│   │       ├── sms_queue_service.dart
│   │       └── permission_service.dart
│   ├── domain/
│   │   ├── models/
│   │   │   ├── transaction.dart
│   │   │   ├── category_rule.dart
│   │   │   ├── sender_allowlist_entry.dart
│   │   │   ├── sync_state.dart
│   │   │   ├── money.dart               # paise helpers, format rupees
│   │   │   └── overview_snapshot.dart
│   │   └── use_cases/
│   │       ├── parse_sms_use_case.dart
│   │       ├── categorize_merchant_use_case.dart
│   │       └── sync_inbox_use_case.dart
│   └── ui/
│       ├── core/
│       │   ├── theme/
│       │   ├── widgets/                 # money text, empty state, month switcher
│       │   └── formatters.dart
│       └── features/
│           ├── overview/
│           │   ├── view_models/overview_view_model.dart
│           │   └── views/overview_view.dart
│           ├── transactions/
│           │   ├── view_models/transactions_view_model.dart
│           │   └── views/
│           │       ├── transactions_view.dart
│           │       └── add_manual_view.dart
│           └── settings/
│               ├── view_models/settings_view_model.dart
│               └── views/settings_view.dart
├── test/
│   ├── domain/
│   │   ├── parse_sms_use_case_test.dart
│   │   └── categorize_merchant_use_case_test.dart
│   └── fixtures/
│       └── sample_sms.dart
└── android/app/src/main/kotlin/com/moneytrail/app/
    ├── MainActivity.kt
    └── sms/
        ├── SmsPlugin.kt                 # MethodChannel
        ├── SmsReceivedReceiver.kt
        └── SmsQueueHelper.kt
```

---

## 5. Domain models

Immutable. Amounts always `int` paise (`int`/`int64`).

### Enums

```dart
enum TransactionType { debit, credit }

enum TransactionSource { kotak, slice, gpayManual, cashManual }
```

### `Transaction`

| Field | Type | Notes |
|---|---|---|
| `id` | `int` | 0/unset before insert |
| `amountPaise` | `int` | never double |
| `type` | `TransactionType` | v0 inserts are debit only |
| `source` | `TransactionSource` | |
| `merchant` | `String?` | null if unknown / skipped |
| `category` | `String` | default `"uncategorized"` |
| `txnTimestamp` | `DateTime` | SMS timestamp, or now if manual |
| `isManual` | `bool` | |
| `rawSmsBody` | `String?` | null if manual |
| `sender` | `String?` | raw sender id e.g. `VM-KOTAKB`; null if manual |
| `messageHash` | `String?` | null if manual |
| `createdAt` | `DateTime` | |

### `CategoryRule`

`id`, `keyword` (lowercase, unique), `category`, `priority` (higher wins).

### `SenderAllowlistEntry`

`id`, `name` (e.g. `KOTAK`, `SLICE`), `enabled`.

### `SyncState`

`lastSyncedAt` (`DateTime?` — null means never synced), `firstRunWindowDays` (default 60).

### `OverviewSnapshot`

Immutable: `month` (`DateTime` first of month), `totalPaise`, `bySource` (`Map<TransactionSource, int>`), `byCategory` (`List<({String category, int totalPaise})>` sorted desc), `topMerchants` (`List<({String merchant, int totalPaise, int count})>` top 10).

### `Money`

Helpers: `rupeesToPaise(String/double input)` (parse user rupees → paise, rounding to nearest paise), `paiseToRupeeLabel(int)` → `"₹1,234.50"`.

---

## 6. Drift schema (port of Room)

Database file: **`moneytrail.db`**.

Match column intent from `tracker/data/entity/*.kt` and DAOs.

### `transactions`

- `id` INTEGER PK autoincrement
- `amount_paise` INTEGER NOT NULL
- `type` TEXT NOT NULL  (`DEBIT` / `CREDIT` — store enum **name uppercase** to match existing Kotlin converters, for a possible later native reader)
- `source` TEXT NOT NULL (`KOTAK`, `SLICE`, `GPAY_MANUAL`, `CASH_MANUAL`)
- `merchant` TEXT NULL
- `category` TEXT NOT NULL DEFAULT `'uncategorized'`
- `txn_timestamp` INTEGER NOT NULL (epoch millis)
- `is_manual` INTEGER NOT NULL (0/1)
- `raw_sms_body` TEXT NULL
- `sender` TEXT NULL
- `message_hash` TEXT NULL
- `created_at` INTEGER NOT NULL
- **UNIQUE index** on `message_hash` (SQLite allows multiple NULLs — that is required for manuals)
- Index on `txn_timestamp`

Insert of a duplicate hash must be **ignored**, not thrown (`InsertMode.insertOrIgnore` / equivalent). Return 0 or existing behavior that callers treat as “already stored”.

Queries (see `TransactionDao.kt`):

- Observe transactions in `[startMillis, endMillis]` ordered `txn_timestamp DESC`
- Debit totals by source in range
- Debit totals by category in range, `total DESC`
- Top merchants in range (merchant NOT NULL, debit, limit 10)

### `category_rules`

- `id`, `keyword` UNIQUE, `category`, `priority` DEFAULT 0
- Observe all `ORDER BY priority DESC`
- One-shot `getAll()` for parser

### `sender_allowlist`

- `id`, `name` UNIQUE, `enabled` DEFAULT 1
- Observe all `ORDER BY name`
- `getEnabledNames()` for sync/receiver

### `sync_state`

- Singleton row `id = 1`
- `last_synced_at` INTEGER (millis, 0 or NULL if never)
- `first_run_window_days` INTEGER DEFAULT 60
- Upsert REPLACE on id=1

### `inbox_queue` (new, native + Dart drain)

- `id` INTEGER PK autoincrement
- `sender` TEXT NOT NULL
- `body` TEXT NOT NULL
- `received_at` INTEGER NOT NULL (epoch millis)
- Native receiver INSERTs here. Dart deletes after successful parse attempt (including skips — do not reprocess forever). Optionally keep a `processed` flag; deleting is fine for v0.

### Seed on first open

Allowlist:

- `KOTAK` enabled
- `SLICE` enabled

Category rules (keyword lowercase, examples — adjust priority so more specific wins):

| keyword | category | priority |
|---|---|---|
| swiggy | food | 10 |
| zomato | food | 10 |
| uber | travel | 10 |
| ola | travel | 10 |
| electricity | bills | 10 |
| jio | bills | 5 |
| amazon | shopping | 5 |
| flipkart | shopping | 5 |

---

## 7. Parser (`ParseSmsUseCase`)

**Input:** `sender`, `body`, `timestamp` (millis), `enabledAllowlistNames`, `rules`.

**Output:** `Transaction?` plus a skip reason for the Settings tester:

Skip reasons (string enum or sealed class): `senderNotAllowed`, `noAmount`, `notDebit`, `looksLikeOtp`, `looksLikePromo`, `creditOrRefund`, `unparseable`.

### Pipeline (in order)

1. **Normalize sender.** Uppercase. Strip known carrier prefixes (`VM-`, `AX-`, `AD-`, `JK-`, `JD-`, `BX-`, `CP-`, `VK-`, `TM-`) and a trailing `-S` / `-T` style suffix so `VM-KOTAKB` and `AX-KOTAKB-S` both remain something that **contains** an allowlist name.
2. **Allowlist.** Enabled name matches if normalized sender **contains** that name (`KOTAK` matches `KOTAKB`). Else skip `senderNotAllowed`.
3. **OTP / promo skip.** If body matches OTP patterns (`otp`, `one time password`, `verification code`) or obvious promo (`offer`, `limited time`, `click here`, `https://`) **without** a debit keyword — skip. Prefer: if debit keyword + amount present, do **not** skip as promo.
4. **Amount.** Extract first money amount: `Rs.?`, `INR`, `₹` followed by number with optional commas and 2 decimal places. Convert to paise (integer). No match → `noAmount`.
5. **Debit vs credit.** Debit keywords (case-insensitive): `debited`, `spent`, `sent`, `paid`, `purchase`, `withdrawn`. Credit/refund keywords: `credited`, `refund`, `received`, `deposited`. If credit → skip `creditOrRefund`. If no debit keyword → `notDebit`.
6. **Merchant.** Try in order:
   - `to <name>`
   - `at <name>`
   - UPI VPA (`[\w.\-]+@[\w]+`)
   - `Info:\s*(.+)` (first token / until newline)
   - Trim trailing punctuation; collapse whitespace; if empty → merchant null.
7. **Source.** If allowlist hit is `KOTAK` → `kotak`; `SLICE` → `slice`. If both (should not happen), first enabled match in name-length-desc order.
8. **Hash.** `sha256(utf8(body) + timestampMillis.toString())` hex lowercase.
9. **Category.** `CategorizeMerchantUseCase`: lowercase merchant (or empty), find rules whose `keyword` is contained in merchant (or in body if merchant null), highest `priority` wins. Default `uncategorized`.
10. Build `Transaction` with `isManual: false`, `type: debit`.

### Settings tester

Same use case. ViewModel calls it and shows: skip reason **or** amount, merchant, source, category, hash. **Must not insert.**

### Unit tests (`test/domain/parse_sms_use_case_test.dart`)

Use fixtures in `test/fixtures/sample_sms.dart`. Real Kotak/Slice samples are not in the repo yet — use **synthetic but realistic** messages:

**Kotak debit (must parse):**

```
Sender: VM-KOTAKB
Body: Dear Customer, Rs.250.00 has been debited from your a/c XX1234 to SWIGGY on 01-10-26. UPI: swiggy@okaxis. Not you? Call 18602662666
Timestamp: 1727770000000
```

Expect: 25000 paise, merchant containing Swiggy (or VPA), source kotak, category food.

**Kotak with AX prefix (must parse):**

```
Sender: AX-KOTAKB-S
Body: INR 1,199.00 debited from Kotak a/c XX9876 at AMAZON on 30-09-26. Info: UPI
```

Expect: 119900 paise, source kotak, category shopping.

**Slice debit (must parse):**

```
Sender: VK-SLICEIN
Body: Spent Rs 450.50 at Zomato on your Slice card ending 1234.
```

Allowlist name `SLICE` must match `SLICEIN`. Expect: 45050 paise, food.

**OTP (skip):**

```
Sender: VM-KOTAKB
Body: 482193 is your OTP for login. Do not share.
```

**Credit (skip):**

```
Sender: VM-KOTAKB
Body: Rs.100.00 credited to your a/c XX1234 from REFUND.
```

**Unknown sender (skip):**

```
Sender: VM-PROMOJ
Body: Rs.50.00 debited to FOO
```

**Dedup:** same body+timestamp → identical hash. Different timestamp → different hash.

Also test `CategorizeMerchantUseCase` in isolation (priority, default uncategorized).

---

## 8. Native Android (SMS)

Channel name: `com.moneytrail.app/sms`

### Methods

| Method | Args | Result |
|---|---|---|
| `hasSmsPermission` | — | bool (READ_SMS + RECEIVE_SMS) |
| `requestSmsPermission` | — | bool granted (or hop to Android settings if needed) |
| `queryInbox` | `sinceMillis` (long), `limit` (int, default 500) | list of `{sender, body, timestampMillis}` |
| `drainQueue` | — | list of `{id, sender, body, receivedAt}` |
| `deleteQueueIds` | `ids` list | ok |

### Inbox query

`content://sms/inbox`, selection `date > ?`, newest first. Map address → sender, body, date.

### `SmsReceivedReceiver`

On `SMS_RECEIVED`:

1. Extract originating address + body + timestamp (`System.currentTimeMillis()` if PDU date missing).
2. Open `moneytrail.db` (same path Drift uses: app database dir, filename `moneytrail.db`). If DB file does not exist yet, still insert into queue by creating the table if needed (`CREATE TABLE IF NOT EXISTS inbox_queue ...`).
3. INSERT into `inbox_queue`.
4. Do **not** parse in Kotlin.
5. Optionally send a broadcast/event to Flutter if engine is running (`EventChannel` `com.moneytrail.app/sms_events` with `queue_updated`). If Flutter is dead, do nothing else.

**Do not start a Flutter engine from the receiver.** Inbox sync is the reliability path.

### Queue drain (Dart `SmsQueueService`)

On app start, on event, and after permission grant:

1. `drainQueue`
2. For each row, `ParseSmsUseCase`
3. If transaction, `TransactionRepository.insert` (ignore dup)
4. `deleteQueueIds` for processed rows (including skips)

### Inbox sync (`SyncInboxUseCase`)

1. Load enabled allowlist names and rules and `SyncState`.
2. `since = lastSyncedAt ?? (now - firstRunWindowDays)`.
3. `queryInbox(since)`.
4. Parse each; insert-ignore.
5. Set `lastSyncedAt = now` (even if some messages skipped).

Call from: app resume (Overview), Settings “Sync now”.

If SMS permission is missing: do not crash; Settings shows “SMS permission: denied”; sync is a no-op with a user-visible message.

---

## 9. Repositories

### `TransactionRepository`

- `watchForRange(start, end)` → `Stream<List<Transaction>>`
- `watchOverview(start, end)` → `Stream<OverviewSnapshot>` (or compose from DAO totals)
- `insert(Transaction)` → insert or ignore on hash
- `updateCategory(id, category)`
- `delete(id)`
- `addManual({amountPaise, source, merchant, category, timestamp})` — `isManual: true`, `messageHash: null`, `rawSmsBody: null`, `sender: null`

### `CategoryRuleRepository`

- `watchAll()`, `getAll()`, `upsert`, `delete`

### `SenderAllowlistRepository`

- `watchAll()`, `getEnabledNames()`, `upsert`, `delete`  
- Protect against deleting the last entry? Not required. Allow empty allowlist (sync will store nothing).

### `SyncStateRepository`

- `get()`, `save(SyncState)`

Map Drift rows → domain in the repository, not in the ViewModel.

---

## 10. ViewModels and Views

### Navigation

`Scaffold` + `NavigationBar` with three destinations: Overview, Transactions, Settings. Provide each feature ViewModel at the app/root via `provider`.

### OverviewViewModel

- Inject `TransactionRepository`
- State: selected month (`DateTime`), `OverviewSnapshot?`, `isLoading`, `error`
- Commands: `previousMonth()`, `nextMonth()` (do not go past current month unless you want to — allowing future empty months is ok, clamp to current month as nicer UX)
- Listen to `watchOverview` for the selected month’s `[start, end)` in local timezone.

### OverviewView

- Month label + prev/next
- Total spend
- Three numbers or bars: Kotak, Slice, Manual (sum of `gpayManual` + `cashManual`)
- Category list with a simple horizontal bar (fraction of total)
- Top merchants

### TransactionsViewModel

- Range: default current month, or all recent (current month is enough for v0)
- `transactions`, `isLoading`
- `updateCategory`, `delete`, after add-manual refresh (streams should auto-update)

### TransactionsView

- List tiles: merchant (or “Manual”), amount, category, source, date
- Swipe or icon to delete (confirm dialog)
- Tap category → simple dialog/picker: `food`, `travel`, `bills`, `shopping`, `uncategorized`, plus free-text optional
- FAB → `AddManualView`

### AddManualView / ViewModel

- Amount in rupees (text field) → paise
- Source: GPay | Cash
- Optional merchant
- Category picker
- Save → repository `addManual`

### SettingsViewModel

- `hasSmsPermission`, `allowlist`, `isSyncing`, `testOutput` (parsed summary or skip reason)
- `requestPermission()`, `syncNow()` → `SyncInboxUseCase`, `addSender(name)`, `toggleSender(id)`, `removeSender(id)`, `testParse(rawSender, rawBody)` → `ParseSmsUseCase` with timestamp = now, **no insert**
- Also drain queue after permission / on appear

### SettingsView

- Permission row + request button
- Allowlist list (enable switch, add field, delete)
- Sync now button
- Two text fields (sender, body) + “Parse” + result card

---

## 11. DI (`di.dart` / `main.dart`)

```text
AppDatabase (singleton)
DatabaseService
SmsInboxService
SmsQueueService
PermissionService
TransactionRepository
CategoryRuleRepository
SenderAllowlistRepository
SyncStateRepository
ParseSmsUseCase
CategorizeMerchantUseCase
SyncInboxUseCase
OverviewViewModel
TransactionsViewModel
SettingsViewModel
```

`Provider` / `ChangeNotifierProvider` with constructor injection. `WidgetsFlutterBinding.ensureInitialized()` then open Drift before `runApp`.

On start: if permission granted, `SyncInboxUseCase` + queue drain (fire-and-forget; ViewModels listen to streams).

---

## 12. UI quality bar

- Material 3, dark-capable `ColorScheme.fromSeed` (pick a distinctive seed — not default purple-only demo if easy; a deep green/teal “ledger” look is fine)
- All money through `paiseToRupeeLabel`
- Empty states when no transactions
- No business logic in `build()` beyond trivial null checks

---

## 13. Implementation order (do in this sequence)

Tick mentally; implement fully before moving on.

1. `flutter create` + gradle minSdk 26 + manifests (permissions, no INTERNET in main, allowBackup false)
2. Domain models (`freezed` or equivalent) + `Money` helpers
3. Drift tables + `AppDatabase` + seed
4. Repositories
5. `CategorizeMerchantUseCase` + `ParseSmsUseCase` + **unit tests** — run `flutter test` until green
6. Native `SmsPlugin` + inbox query + permission methods
7. `SmsInboxService` + `SyncInboxUseCase`
8. Native receiver + `inbox_queue` + Dart drain
9. Overview ViewModel + View
10. Transactions + Add manual
11. Settings (allowlist, sync, paste tester)
12. `provider` wiring, app resume sync, navigation
13. Re-run `flutter test` and `flutter analyze`

---

## 14. Out of scope (do not build)

- CSV/PDF statement import
- iOS / web
- Storing credits as income
- Cloud backup, accounts, login
- Foreground service / Flutter engine in the BroadcastReceiver
- Editing keyword rules UI (seeded rules are enough; user can still override per-transaction category)
- Multiple profiles / multiple phones

---

## 15. Architecture skill mapping (feature workflow)

For every feature:

1. Domain models  
2. Services  
3. Repositories  
4. Use case only if complex / shared  
5. ViewModel (`ChangeNotifier`, immutable state)  
6. View (`ListenableBuilder`)  
7. Register in `provider`  
8. Tests for ViewModel/Repository/use case — **parser tests are mandatory**; Overview ViewModel tests optional if timeboxed

---

## 16. Definition of done

- `money_trail/` is a compilable Flutter Android project
- Layer folders match section 4
- Parser unit tests pass on fixtures in section 7
- Duplicate SMS (same body+timestamp) cannot create two rows
- Manual entries never participate in hash uniqueness failures
- Settings paste tester uses `ParseSmsUseCase` and does not write DB
- No INTERNET in main manifest; `allowBackup=false`
- Native receiver only queues raw SMS; Dart parses
- `tracker/` Kotlin files left intact
