package com.wulisu.suspect.interrogation.data

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import net.zetetic.database.sqlcipher.SupportOpenHelperFactory

@Database(entities = [CaseEntity::class, SessionEntity::class, QaRecordEntity::class, QaRevisionEntity::class, FactEntity::class, TimelineEntity::class, AuditLogEntity::class], version = 1, exportSchema = true)
abstract class AppDatabase : RoomDatabase() {
    abstract fun caseDao(): CaseDao
    abstract fun sessionDao(): SessionDao
    abstract fun qaDao(): QaDao
    abstract fun revisionDao(): RevisionDao
    abstract fun factDao(): FactDao
    abstract fun timelineDao(): TimelineDao
    abstract fun auditDao(): AuditDao

    companion object {
        fun build(context: Context): AppDatabase {
            System.loadLibrary("sqlcipher")
            val passphrase = DatabaseKeyProvider(context).getOrCreatePassphrase()
            val factory = SupportOpenHelperFactory(passphrase)
            return Room.databaseBuilder(context.applicationContext, AppDatabase::class.java, context.getDatabasePath("suspect-interrogation.db").absolutePath).openHelperFactory(factory).build()
        }
    }
}
