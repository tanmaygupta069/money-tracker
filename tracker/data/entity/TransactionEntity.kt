package com.moneytrail.app.data.entity

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

enum class TransactionType { DEBIT, CREDIT }

enum class TransactionSource { KOTAK, SLICE, GPAY_MANUAL, CASH_MANUAL }

@Entity(
    tableName = "transactions",
    indices = [
        Index(value = ["message_hash"], unique = true),
        Index(value = ["txn_timestamp"])
    ]
)
data class TransactionEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,

    // integer paise, never float
    val amountPaise: Long,

    val type: TransactionType,

    val source: TransactionSource,

    // null for manual entries that skip merchant entry
    val merchant: String? = null,

    val category: String = "uncategorized",

    // epoch millis: SMS timestamp, or entry time if manual
    val txnTimestamp: Long,

    val isManual: Boolean,

    // null for manual entries
    val rawSmsBody: String? = null,

    // raw sender id, e.g. "VM-KOTAKB"; null for manual entries
    val sender: String? = null,

    // sha256(body + timestamp); null for manual entries so dedup never applies to them
    val messageHash: String? = null,

    val createdAt: Long
)
