package com.wulisu.suspect.interrogation.data

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.migration.Migration
import androidx.sqlite.db.SupportSQLiteDatabase
import net.zetetic.database.sqlcipher.SupportOpenHelperFactory

@Database(
    entities = [
        CaseEntity::class,
        SessionEntity::class,
        QaRecordEntity::class,
        QaRevisionEntity::class,
        FactEntity::class,
        TimelineEntity::class,
        AuditLogEntity::class,
        AiCaseAnalysisEntity::class,
        AsrCaptureSessionEntity::class,
        AsrTemporaryFragmentEntity::class,
    ],
    version = 5,
    exportSchema = true,
)
abstract class AppDatabase : RoomDatabase() {
    abstract fun caseDao(): CaseDao
    abstract fun sessionDao(): SessionDao
    abstract fun qaDao(): QaDao
    abstract fun revisionDao(): RevisionDao
    abstract fun factDao(): FactDao
    abstract fun timelineDao(): TimelineDao
    abstract fun auditDao(): AuditDao
    abstract fun aiCaseAnalysisDao(): AiCaseAnalysisDao
    abstract fun asrCaptureSessionDao(): AsrCaptureSessionDao
    abstract fun asrTemporaryFragmentDao(): AsrTemporaryFragmentDao

    companion object {
        fun build(context: Context): AppDatabase {
            System.loadLibrary("sqlcipher")
            val passphrase = DatabaseKeyProvider(context).getOrCreatePassphrase()
            val factory = SupportOpenHelperFactory(passphrase)
            return Room.databaseBuilder(context.applicationContext, AppDatabase::class.java, context.getDatabasePath("suspect-interrogation.db").absolutePath)
                .openHelperFactory(factory)
                .addMigrations(MIGRATION_1_2, MIGRATION_2_3, MIGRATION_3_4, MIGRATION_4_5)
                .build()
        }

        val MIGRATION_1_2 = object : Migration(1, 2) {
            override fun migrate(db: SupportSQLiteDatabase) {
                db.execSQL(
                    """CREATE TABLE IF NOT EXISTS `asr_capture_sessions` (`id` TEXT NOT NULL, `caseId` TEXT NOT NULL, `interrogationSessionId` TEXT NOT NULL, `modelId` TEXT NOT NULL, `modelName` TEXT NOT NULL, `provider` TEXT NOT NULL, `sherpaVersion` TEXT NOT NULL, `sampleRate` INTEGER NOT NULL, `audioRelativePath` TEXT NOT NULL, `startedAt` INTEGER NOT NULL, `endedAt` INTEGER, `state` TEXT NOT NULL, `error` TEXT, PRIMARY KEY(`id`), FOREIGN KEY(`caseId`) REFERENCES `cases`(`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY(`interrogationSessionId`) REFERENCES `interrogation_sessions`(`id`) ON UPDATE NO ACTION ON DELETE CASCADE)""",
                )
                db.execSQL("CREATE INDEX IF NOT EXISTS `index_asr_capture_sessions_caseId` ON `asr_capture_sessions` (`caseId`)")
                db.execSQL("CREATE INDEX IF NOT EXISTS `index_asr_capture_sessions_interrogationSessionId` ON `asr_capture_sessions` (`interrogationSessionId`)")
                db.execSQL("CREATE INDEX IF NOT EXISTS `index_asr_capture_sessions_caseId_startedAt` ON `asr_capture_sessions` (`caseId`, `startedAt`)")
                db.execSQL(
                    """CREATE TABLE IF NOT EXISTS `asr_temporary_fragments` (`id` TEXT NOT NULL, `captureSessionId` TEXT NOT NULL, `caseId` TEXT NOT NULL, `ordinal` INTEGER NOT NULL, `startedAtMs` INTEGER NOT NULL, `endedAtMs` INTEGER NOT NULL, `audioStartOffsetMs` INTEGER NOT NULL, `audioEndOffsetMs` INTEGER NOT NULL, `rawText` TEXT NOT NULL, `editedText` TEXT NOT NULL, `speaker` TEXT NOT NULL, `speakerSource` TEXT NOT NULL, `confidence` REAL, `confidenceSource` TEXT NOT NULL, `state` TEXT NOT NULL, `confirmedQaId` TEXT, `createdAt` INTEGER NOT NULL, `updatedAt` INTEGER NOT NULL, PRIMARY KEY(`id`), FOREIGN KEY(`captureSessionId`) REFERENCES `asr_capture_sessions`(`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY(`caseId`) REFERENCES `cases`(`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY(`confirmedQaId`) REFERENCES `qa_records`(`id`) ON UPDATE NO ACTION ON DELETE SET NULL)""",
                )
                db.execSQL("CREATE INDEX IF NOT EXISTS `index_asr_temporary_fragments_captureSessionId` ON `asr_temporary_fragments` (`captureSessionId`)")
                db.execSQL("CREATE INDEX IF NOT EXISTS `index_asr_temporary_fragments_caseId` ON `asr_temporary_fragments` (`caseId`)")
                db.execSQL("CREATE INDEX IF NOT EXISTS `index_asr_temporary_fragments_confirmedQaId` ON `asr_temporary_fragments` (`confirmedQaId`)")
                db.execSQL("CREATE UNIQUE INDEX IF NOT EXISTS `index_asr_temporary_fragments_captureSessionId_ordinal` ON `asr_temporary_fragments` (`captureSessionId`, `ordinal`)")
            }
        }

        val MIGRATION_2_3 = object : Migration(2, 3) {
            override fun migrate(db: SupportSQLiteDatabase) {
                db.execSQL("ALTER TABLE `cases` ADD COLUMN `idNumber` TEXT")
                db.execSQL("ALTER TABLE `cases` ADD COLUMN `nation` TEXT")
                db.execSQL("ALTER TABLE `cases` ADD COLUMN `birthDate` TEXT")
                db.execSQL("ALTER TABLE `cases` ADD COLUMN `address` TEXT")
                db.execSQL("ALTER TABLE `cases` ADD COLUMN `identitySource` TEXT")
                db.execSQL("ALTER TABLE `cases` ADD COLUMN `identityCapturedAt` INTEGER")
            }
        }

        val MIGRATION_3_4 = object : Migration(3, 4) {
            override fun migrate(db: SupportSQLiteDatabase) {
                db.execSQL(
                    """CREATE TABLE IF NOT EXISTS `ai_case_analyses` (`id` TEXT NOT NULL, `caseId` TEXT NOT NULL, `text` TEXT NOT NULL, `provider` TEXT NOT NULL, `model` TEXT NOT NULL, `createdAt` INTEGER NOT NULL, PRIMARY KEY(`id`), FOREIGN KEY(`caseId`) REFERENCES `cases`(`id`) ON UPDATE NO ACTION ON DELETE CASCADE)""",
                )
                db.execSQL("CREATE INDEX IF NOT EXISTS `index_ai_case_analyses_caseId` ON `ai_case_analyses` (`caseId`)")
                db.execSQL("CREATE INDEX IF NOT EXISTS `index_ai_case_analyses_caseId_createdAt` ON `ai_case_analyses` (`caseId`, `createdAt`)")
            }
        }

        val MIGRATION_4_5 = object : Migration(4, 5) {
            override fun migrate(db: SupportSQLiteDatabase) {
                db.execSQL("ALTER TABLE `ai_case_analyses` ADD COLUMN `metadataJson` TEXT NOT NULL DEFAULT '{}'")
            }
        }
    }
}
