package com.moneytrail.app.data.entity

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(
    tableName = "sender_allowlist",
    indices = [Index(value = ["name"], unique = true)]
)
data class SenderAllowlistEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,

    // matched against the sender id with the carrier prefix stripped, e.g. "KOTAK", "SLICE"
    val name: String,

    val enabled: Boolean = true
)
