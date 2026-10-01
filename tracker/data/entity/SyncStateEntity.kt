package com.moneytrail.app.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

// single enforced row (id always 1) tracking where the next inbox sync should resume from
@Entity(tableName = "sync_state")
data class SyncStateEntity(
    @PrimaryKey
    val id: Int = SINGLETON_ID,

    val lastSyncedAt: Long,

    val firstRunWindowDays: Int = 60
) {
    companion object {
        const val SINGLETON_ID = 1
    }
}
