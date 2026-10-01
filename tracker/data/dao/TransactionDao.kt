package com.moneytrail.app.data.dao

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update
import com.moneytrail.app.data.entity.TransactionEntity
import kotlinx.coroutines.flow.Flow

@Dao
interface TransactionDao {

    // IGNORE on the message_hash unique index is the dedup guard: a re-synced
    // duplicate SMS silently fails to insert instead of throwing.
    @Insert(onConflict = OnConflictStrategy.IGNORE)
    suspend fun insert(transaction: TransactionEntity): Long

    @Update
    suspend fun update(transaction: TransactionEntity)

    @Delete
    suspend fun delete(transaction: TransactionEntity)

    @Query("""
        SELECT * FROM transactions
        WHERE txn_timestamp BETWEEN :startMillis AND :endMillis
        ORDER BY txn_timestamp DESC
    """)
    fun observeForRange(startMillis: Long, endMillis: Long): Flow<List<TransactionEntity>>

    @Query("""
        SELECT source, SUM(amountPaise) AS total
        FROM transactions
        WHERE type = 'DEBIT' AND txn_timestamp BETWEEN :startMillis AND :endMillis
        GROUP BY source
    """)
    fun observeTotalsBySource(startMillis: Long, endMillis: Long): Flow<List<SourceTotal>>

    @Query("""
        SELECT category, SUM(amountPaise) AS total
        FROM transactions
        WHERE type = 'DEBIT' AND txn_timestamp BETWEEN :startMillis AND :endMillis
        GROUP BY category
        ORDER BY total DESC
    """)
    fun observeTotalsByCategory(startMillis: Long, endMillis: Long): Flow<List<CategoryTotal>>

    @Query("""
        SELECT merchant, SUM(amountPaise) AS total, COUNT(*) AS count
        FROM transactions
        WHERE type = 'DEBIT' AND merchant IS NOT NULL
          AND txn_timestamp BETWEEN :startMillis AND :endMillis
        GROUP BY merchant
        ORDER BY total DESC
        LIMIT :limit
    """)
    fun observeTopMerchants(startMillis: Long, endMillis: Long, limit: Int = 10): Flow<List<MerchantTotal>>
}

data class SourceTotal(val source: String, val total: Long)
data class CategoryTotal(val category: String, val total: Long)
data class MerchantTotal(val merchant: String, val total: Long, val count: Int)
