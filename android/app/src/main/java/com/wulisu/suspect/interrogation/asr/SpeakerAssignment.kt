package com.wulisu.suspect.interrogation.asr

enum class SpeakerAssignmentKind { AUTO, MANUAL, UNASSIGNED }

val SpeakerSource.assignmentKind: SpeakerAssignmentKind
    get() = when (this) {
        SpeakerSource.DIARIZATION -> SpeakerAssignmentKind.AUTO
        SpeakerSource.MANUAL -> SpeakerAssignmentKind.MANUAL
        SpeakerSource.UNASSIGNED -> SpeakerAssignmentKind.UNASSIGNED
    }
