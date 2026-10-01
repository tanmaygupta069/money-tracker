package com.moneytrail.app.data.dao

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.moneytrail.app.data.entity.SenderAllowlistEntity
import kotlinx.coroutines.flow.Flow

@Dao
interface SenderAllowlistDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsert(entry: SenderAllowlistEntity)

    @Delete
    suspend fun delete(entry: SenderAllowlistEntity)

    @Query("SELECT * FROM sender_allowlist ORDER BY name")
    fun observeAll(): Flow<List<SenderAllowlistEntity>>

    // one-shot read used by the live receiver and the inbox sync to filter incoming SMS
    @Query("SELECT name FROM sender_allowlist WHERE enabled = 1")
    suspend fun getEnabledNames(): List<String>
}
