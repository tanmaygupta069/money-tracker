package com.moneytrail.app.data.entity

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(
    tableName = "category_rules",
    indices = [Index(value = ["keyword"], unique = true)]
)
data class CategoryRuleEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,

    // e.g. "swiggy", "uber", "electricity" — matched against the extracted merchant
    val keyword: String,

    // e.g. "food", "travel", "bills"
    val category: String,

    // higher wins when a merchant matches more than one rule
    val priority: Int = 0
)
