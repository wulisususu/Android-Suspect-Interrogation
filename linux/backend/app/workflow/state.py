from app.domain.enums import WorkflowState
from app.domain.errors import DomainError


class StateMachine:
    _allowed = {
        WorkflowState.INIT: {WorkflowState.IDENTITY_REQUIRED},
        WorkflowState.IDENTITY_REQUIRED: {WorkflowState.IDENTITY_READY},
        WorkflowState.IDENTITY_READY: {WorkflowState.CASE_CREATED},
        WorkflowState.CASE_CREATED: {WorkflowState.QUESTIONING},
        WorkflowState.QUESTIONING: {WorkflowState.PAUSED, WorkflowState.SUMMARY},
        WorkflowState.PAUSED: {WorkflowState.QUESTIONING, WorkflowState.SUMMARY},
        WorkflowState.SUMMARY: {WorkflowState.FROZEN},
        WorkflowState.FROZEN: {WorkflowState.SIGNED},
        WorkflowState.SIGNED: {WorkflowState.REPORT_GENERATED},
        WorkflowState.REPORT_GENERATED: set(),
    }

    @classmethod
    def validate_transition(cls, current: WorkflowState | str, target: WorkflowState | str) -> None:
        current_state = WorkflowState(current)
        target_state = WorkflowState(target)
        if target_state not in cls._allowed[current_state]:
            raise DomainError(
                "INVALID_STATE_TRANSITION",
                f"非法状态转换：{current_state.value} -> {target_state.value}",
                409,
                {"current": current_state.value, "target": target_state.value},
            )

    @classmethod
    def transition(cls, current: WorkflowState | str, target: WorkflowState | str) -> WorkflowState:
        cls.validate_transition(current, target)
        return WorkflowState(target)
