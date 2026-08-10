package com.wulisu.suspect.interrogation.domain

object InterrogationRules {
    private val stages = InterrogationStage.entries.toSet()

    fun requireValidStage(stage: InterrogationStage): InterrogationStage {
        if (stage !in stages) throw BusinessException("INVALID_STAGE", "无效审讯阶段")
        return stage
    }

    fun requireCanPause(status: SessionStatus) {
        if (status != SessionStatus.RUNNING) {
            throw BusinessException("SESSION_NOT_RUNNING", "当前没有正在进行的审讯")
        }
    }

    fun requireCanResume(status: SessionStatus) {
        if (status != SessionStatus.PAUSED) {
            throw BusinessException("SESSION_NOT_PAUSED", "当前审讯不是暂停状态")
        }
    }

    fun requireCanRecord(status: SessionStatus) {
        when (status) {
            SessionStatus.RUNNING -> Unit
            SessionStatus.PAUSED -> throw BusinessException("SESSION_PAUSED", "审讯已暂停，恢复后才能继续记录")
            else -> throw BusinessException("SESSION_NOT_ACTIVE", "请先开始审讯再记录问答")
        }
    }

    fun requireNonBlankMessage(text: String): String {
        val clean = text.trim()
        if (clean.isEmpty()) throw BusinessException("EMPTY_MESSAGE", "问答内容不能为空")
        return clean
    }
}
