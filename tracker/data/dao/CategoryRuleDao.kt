package com.moneytrail.app.data.dao

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.moneytrail.app.data.entity.CategoryRuleEntity
import kotlinx.coroutines.flow.Flow

@Dao
interface CategoryRuleDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsert(rule: CategoryRuleEntity)

    @Delete
    suspend fun delete(rule: CategoryRuleEntity)

    @Query("SELECT * FROM category_rules ORDER BY priority DESC")
    fun observeAll(): Flow<List<CategoryRuleEntity>>

    // one-shot read for the parser pipeline, not an observed stream
    @Query("SELECT * FROM category_rules ORDER BY priority DESC")
    suspend fun getAll(): List<CategoryRuleEntity>
}
