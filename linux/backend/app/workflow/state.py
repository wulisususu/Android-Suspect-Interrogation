from enum import Enum


class InterrogationState(str, Enum):
    INIT = "init"
    IDENTITY = "identity_verify"
    CASE_CREATE = "case_create"
    QUESTIONING = "questioning"
    SUMMARY = "summary"
    REPORT = "report"


class StateMachine:
    def __init__(self):
        self.state = InterrogationState.INIT

    def transition(self, target: InterrogationState):
        self.state = target
        return self.state
