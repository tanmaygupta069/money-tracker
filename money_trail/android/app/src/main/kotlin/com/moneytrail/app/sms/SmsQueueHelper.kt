package com.moneytrail.app.sms

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import java.io.File

/**
 * Raw SQLite access to the `inbox_queue` table inside `moneytrail.db`.
 *
 * The receiver runs with no Flutter engine, so it cannot go through Drift. It
 * opens the very same file: on Android `path_provider`'s application documents
 * directory resolves to `context.getDir("flutter", MODE_PRIVATE)`.
 *
 * `user_version` is deliberately left alone. Drift decides whether to run its
 * onCreate migration from that value, so bumping it here would stop the
 * remaining tables from ever being created.
 */
internal object SmsQueueHelper {

    private const val DATABASE_FILE = "moneytrail.db"
    private const val TABLE = "inbox_queue"

    private const val CREATE_TABLE =
        "CREATE TABLE IF NOT EXISTS $TABLE (" +
            "id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, " +
            "sender TEXT NOT NULL, " +
            "body TEXT NOT NULL, " +
            "received_at INTEGER NOT NULL)"

    fun enqueue(context: Context, sender: String, body: String, receivedAt: Long) {
        withDatabase(context) { db ->
            val values = ContentValues().apply {
                put("sender", sender)
                put("body", body)
                put("received_at", receivedAt)
            }
            db.insert(TABLE, null, values)
        }
    }

    fun drain(context: Context): List<Map<String, Any?>> {
        return withDatabase(context) { db ->
            val rows = mutableListOf<Map<String, Any?>>()
            db.query(
                TABLE,
                arrayOf("id", "sender", "body", "received_at"),
                null,
                null,
                null,
                null,
                "id ASC"
            ).use { cursor ->
                while (cursor.moveToNext()) {
                    rows += mapOf(
                        "id" to cursor.getLong(0),
                        "sender" to cursor.getString(1),
                        "body" to cursor.getString(2),
                        "receivedAt" to cursor.getLong(3)
                    )
                }
            }
            rows.toList()
        } ?: emptyList()
    }

    fun deleteIds(context: Context, ids: List<Long>) {
        if (ids.isEmpty()) return
        withDatabase(context) { db ->
            val placeholders = ids.joinToString(separator = ",") { "?" }
            db.delete(
                TABLE,
                "id IN ($placeholders)",
                ids.map { it.toString() }.toTypedArray()
            )
        }
    }

    private fun <T> withDatabase(context: Context, block: (SQLiteDatabase) -> T): T? {
        return try {
            val file = File(context.getDir("flutter", Context.MODE_PRIVATE), DATABASE_FILE)
            SQLiteDatabase.openOrCreateDatabase(file, null).use { db ->
                db.execSQL(CREATE_TABLE)
                block(db)
            }
        } catch (error: Exception) {
            // A queue write must never take the process down. The inbox sync is
            // the reliability path and will pick the message up anyway.
            null
        }
    }
}
