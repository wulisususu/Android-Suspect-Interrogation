import pytest

from app.domain.enums import WorkflowState
from app.domain.errors import DomainError
from app.workflow.state import StateMachine


def test_legal_workflow_chain_and_pause_resume():
    chain = [
        WorkflowState.INIT,
        WorkflowState.IDENTITY_REQUIRED,
        WorkflowState.IDENTITY_READY,
        WorkflowState.CASE_CREATED,
        WorkflowState.QUESTIONING,
        WorkflowState.PAUSED,
        WorkflowState.QUESTIONING,
        WorkflowState.SUMMARY,
        WorkflowState.FROZEN,
        WorkflowState.SIGNED,
        WorkflowState.REPORT_GENERATED,
    ]
    for current, target in zip(chain, chain[1:]):
        assert StateMachine.transition(current, target) is target


def test_illegal_workflow_jump_is_rejected():
    with pytest.raises(DomainError) as exc:
        StateMachine.transition(WorkflowState.INIT, WorkflowState.QUESTIONING)
    assert exc.value.code == "INVALID_STATE_TRANSITION"
    assert exc.value.status_code == 409
