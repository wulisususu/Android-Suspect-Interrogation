package com.wulisu.suspect.interrogation.data

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update

@Dao
interface CaseDao {
    @Query("SELECT * FROM cases WHERE id = :id LIMIT 1") suspend fun get(id: String): CaseEntity?
    @Query("SELECT * FROM cases ORDER BY updatedAt DESC LIMIT :limit") suspend fun list(limit: Int = 100): List<CaseEntity>
    @Insert(onConflict = OnConflictStrategy.ABORT) suspend fun insert(entity: CaseEntity)
    @Update suspend fun update(entity: CaseEntity)
}

@Dao
interface SessionDao {
    @Query("SELECT * FROM interrogation_sessions WHERE caseId = :caseId AND status IN ('RUNNING','PAUSED') ORDER BY updatedAt DESC LIMIT 1") suspend fun active(caseId: String): SessionEntity?
    @Query("SELECT * FROM interrogation_sessions WHERE caseId = :caseId ORDER BY updatedAt DESC LIMIT 1") suspend fun latest(caseId: String): SessionEntity?
    @Insert(onConflict = OnConflictStrategy.ABORT) suspend fun insert(entity: SessionEntity)
    @Update suspend fun update(entity: SessionEntity)
}

@Dao
interface QaDao {
    @Query("SELECT * FROM qa_records WHERE caseId = :caseId ORDER BY seq ASC LIMIT :limit") suspend fun list(caseId: String, limit: Int = 1000): List<QaRecordEntity>
    @Query("SELECT * FROM qa_records WHERE id = :id AND caseId = :caseId LIMIT 1") suspend fun get(caseId: String, id: String): QaRecordEntity?
    @Query("SELECT COALESCE(MAX(seq), 0) FROM qa_records WHERE caseId = :caseId") suspend fun maxSeq(caseId: String): Int
    @Insert(onConflict = OnConflictStrategy.ABORT) suspend fun insert(entity: QaRecordEntity)
    @Update suspend fun update(entity: QaRecordEntity)
}

@Dao
interface RevisionDao {
    @Query("SELECT COALESCE(MAX(version), 0) FROM qa_revisions WHERE qaId = :qaId") suspend fun maxVersion(qaId: String): Int
    @Query("SELECT * FROM qa_revisions WHERE caseId = :caseId AND qaId = :qaId ORDER BY version DESC") suspend fun listForQa(caseId: String, qaId: String): List<QaRevisionEntity>
    @Query("SELECT * FROM qa_revisions WHERE caseId = :caseId ORDER BY createdAt DESC LIMIT 200") suspend fun listForCase(caseId: String): List<QaRevisionEntity>
    @Insert(onConflict = OnConflictStrategy.ABORT) suspend fun insert(entity: QaRevisionEntity)
}

@Dao
interface FactDao {
    @Query("SELECT * FROM facts WHERE caseId = :caseId ORDER BY sortOrder ASC") suspend fun list(caseId: String): List<FactEntity>
    @Query("SELECT COUNT(*) FROM facts WHERE caseId = :caseId") suspend fun count(caseId: String): Int
    @Insert(onConflict = OnConflictStrategy.REPLACE) suspend fun insertAll(entities: List<FactEntity>)
}

@Dao
interface TimelineDao {
    @Query("SELECT * FROM timeline_events WHERE caseId = :caseId ORDER BY createdAt ASC") suspend fun list(caseId: String): List<TimelineEntity>
    @Insert(onConflict = OnConflictStrategy.ABORT) suspend fun insert(entity: TimelineEntity)
}

@Dao
interface AuditDao {
    @Insert(onConflict = OnConflictStrategy.ABORT) suspend fun insert(entity: AuditLogEntity)
    @Query("SELECT * FROM audit_logs WHERE caseId = :caseId ORDER BY createdAt DESC LIMIT :limit") suspend fun list(caseId: String, limit: Int = 500): List<AuditLogEntity>
}

@Dao
interface AsrCaptureSessionDao {
    @Query("SELECT * FROM asr_capture_sessions WHERE id = :id LIMIT 1") suspend fun get(id: String): AsrCaptureSessionEntity?
    @Query("SELECT * FROM asr_capture_sessions WHERE caseId = :caseId AND state = 'RECORDING' ORDER BY startedAt DESC LIMIT 1") suspend fun active(caseId: String): AsrCaptureSessionEntity?
    @Query("SELECT * FROM asr_capture_sessions WHERE caseId = :caseId ORDER BY startedAt DESC LIMIT 1") suspend fun latest(caseId: String): AsrCaptureSessionEntity?
    @Insert(onConflict = OnConflictStrategy.ABORT) suspend fun insert(entity: AsrCaptureSessionEntity)
    @Update suspend fun update(entity: AsrCaptureSessionEntity)
}

@Dao
interface AsrTemporaryFragmentDao {
    @Query("SELECT * FROM asr_temporary_fragments WHERE id = :id LIMIT 1") suspend fun get(id: String): AsrTemporaryFragmentEntity?
    @Query("SELECT * FROM asr_temporary_fragments WHERE caseId = :caseId AND (state = 'PENDING' OR (:includeConfirmed = 1 AND state = 'CONFIRMED')) ORDER BY createdAt ASC, ordinal ASC")
    suspend fun list(caseId: String, includeConfirmed: Boolean): List<AsrTemporaryFragmentEntity>
    @Query("SELECT * FROM asr_temporary_fragments WHERE captureSessionId = :captureSessionId AND state = 'PENDING' ORDER BY ordinal ASC")
    suspend fun listPending(captureSessionId: String): List<AsrTemporaryFragmentEntity>
    @Query("SELECT COALESCE(MAX(ordinal), 0) FROM asr_temporary_fragments WHERE captureSessionId = :captureSessionId")
    suspend fun maxOrdinal(captureSessionId: String): Int
    @Insert(onConflict = OnConflictStrategy.ABORT) suspend fun insert(entity: AsrTemporaryFragmentEntity)
    @Update suspend fun update(entity: AsrTemporaryFragmentEntity)
}
