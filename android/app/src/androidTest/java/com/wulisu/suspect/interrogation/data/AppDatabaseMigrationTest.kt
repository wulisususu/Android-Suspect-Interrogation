package com.wulisu.suspect.interrogation.data

import androidx.room.testing.MigrationTestHelper
import androidx.sqlite.db.framework.FrameworkSQLiteOpenHelperFactory
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import org.junit.Assert.assertEquals
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class AppDatabaseMigrationTest {
    @get:Rule
    val helper = MigrationTestHelper(
        InstrumentationRegistry.getInstrumentation(),
        AppDatabase::class.java,
        emptyList(),
        FrameworkSQLiteOpenHelperFactory(),
    )

    @Test
    fun migrate1To2PreservesExistingRecordsAndCreatesCaptureTables() {
        helper.createDatabase(TEST_DB, 1).apply {
            execSQL("INSERT INTO cases VALUES ('case-1','张三',NULL,NULL,'警官','ACTIVE','IDENTITY',1,1)")
            execSQL("INSERT INTO interrogation_sessions VALUES ('session-1','case-1','RUNNING','IDENTITY',1,NULL,NULL,1)")
            execSQL("INSERT INTO qa_records VALUES ('qa-1','case-1','session-1',1,'民警','测试问题','',1,1,1)")
            close()
        }

        helper.runMigrationsAndValidate(TEST_DB, 2, true, AppDatabase.MIGRATION_1_2).apply {
            query("SELECT COUNT(*) FROM qa_records WHERE id = 'qa-1'").use {
                it.moveToFirst()
                assertEquals(1, it.getInt(0))
            }
            query("SELECT COUNT(*) FROM asr_capture_sessions").use {
                it.moveToFirst()
                assertEquals(0, it.getInt(0))
            }
            query("SELECT COUNT(*) FROM asr_temporary_fragments").use {
                it.moveToFirst()
                assertEquals(0, it.getInt(0))
            }
            close()
        }
    }

    companion object {
        private const val TEST_DB = "asr-migration-test"
    }
}
