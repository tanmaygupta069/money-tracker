Project: MoneyTrail, a personal Android expense tracker (v0)

Goal
Track where money goes and how much is spent. It does this automatically by reading bank SMS on the phone. It is for personal use, on one Android phone, and I'll install the APK myself.

Payment sources

Kotak bank account (GPay payments from Kotak show up as Kotak debit SMS)
Slice card
GPay doesn't send its own payment SMS, so it isn't a separate sender. Offer GPay and Cash as manual-entry source options.

Decisions made

Platform: Android only, native Kotlin with Android Studio. Not Expo, Flutter or a web app. A browser page can't read SMS, and Expo's background SMS capture is unreliable.
v0 approach: SMS-based. A statement import (CSV or PDF from Kotak, Slice and GPay) is planned for later, not now.
Capture: Two paths.
A live BroadcastReceiver for SMS_RECEIVED logs new debits as they arrive.
A sync of the SMS inbox on app open catches anything missed, such as when the phone was off. It reads messages newer than the last sync, and on first run the last ~60 days.
Trusted senders only: An allowlist matches on the sender-ID name and ignores the carrier prefix, because VM-KOTAKB, AX-KOTAKB-S and similar vary. Start with KOTAK and SLICE, and make it editable in settings. Everything else is ignored in code.
Parsing: A message becomes a transaction only if it has an amount (Rs., INR or ₹) and a debit keyword (debited, spent, sent, paid, purchase, withdrawn). Skip OTPs and promos. Credits and refunds are either skipped or stored as income. Extract the merchant from patterns like to X, at X, the UPI VPA, or Info:. Use the SMS timestamp as the transaction date.
Privacy: Do not add the INTERNET permission, so nothing can leave the phone. Use allowBackup=false. All data lives in a local Room (SQLite) database.
Deduplication: Hash the raw SMS body plus timestamp, and use a unique index so live capture and inbox sync can't double-count.
Storage: Store amounts as integer paise, not floats.
Categories: Keyword rules map merchant to category (food, travel, bills, shopping and so on). The user can edit a category on any transaction. Manual add is a fallback.

Stack
Kotlin 2.0.x, Jetpack Compose with Material 3, Room with KSP, minSdk 26, targetSdk 34, AGP 8.5.x, Gradle 8.9. Charts are drawn in Compose (simple bars), with no chart library.

Screens

Overview: month total, split by Kotak, Slice and Manual, a category breakdown, top merchants, and a month switcher.
Transactions: a list with edit category, delete and add manual.
Settings: the permission status, the sender allowlist, a "sync now" button, and a paste-an-SMS test box that shows how the parser reads a message.

Tests
Unit tests for the parser against real sample messages. I still need to paste 1–2 real Kotak and Slice SMS each, with account numbers and names removed, because the regexes should match the actual formats.

Open items

Real sample SMS (above).
Whether to store credits as income.