package com.moneytrail.app.data

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.moneytrail.app.data.dao.CategoryRuleDao
import com.moneytrail.app.data.dao.SenderAllowlistDao
import com.moneytrail.app.data.dao.SyncStateDao
import com.moneytrail.app.data.dao.TransactionDao
import com.moneytrail.app.data.entity.CategoryRuleEntity
import com.moneytrail.app.data.entity.SenderAllowlistEntity
import com.moneytrail.app.data.entity.SyncStateEntity
import com.moneytrail.app.data.entity.TransactionEntity

@Database(
    entities = [
        TransactionEntity::class,
        CategoryRuleEntity::class,
        SenderAllowlistEntity::class,
        SyncStateEntity::class
    ],
    version = 1,
    exportSchema = true
)
@TypeConverters(Converters::class)
abstract class MoneyTrailDatabase : RoomDatabase() {

    abstract fun transactionDao(): TransactionDao
    abstract fun categoryRuleDao(): CategoryRuleDao
    abstract fun senderAllowlistDao(): SenderAllowlistDao
    abstract fun syncStateDao(): SyncStateDao

    companion object {
        @Volatile
        private var instance: MoneyTrailDatabase? = null

        fun getInstance(context: Context): MoneyTrailDatabase =
            instance ?: synchronized(this) {
                instance ?: Room.databaseBuilder(
                    context.applicationContext,
                    MoneyTrailDatabase::class.java,
                    "moneytrail.db"
                ).build().also { instance = it }
            }
    }
}
