from dataclasses import dataclass


@dataclass(frozen=True)
class ContextBudget:
    max_context_len: int = 16384
    output_reserve = 5120
    safety_margin = 512

    def __post_init__(self):
        if type(self.max_context_len) is not int or not 0 < self.max_context_len <= 16384:
            raise ValueError('Context length must be an integer between 1 and 16384')

    def fits(self, expanded_input_tokens: int) -> bool:
        """Use the processor's expanded count, including prompt and special tokens."""
        if type(expanded_input_tokens) is not int or expanded_input_tokens < 0:
            raise ValueError('Expanded input token count must be a non-negative integer')
        return (expanded_input_tokens + self.output_reserve + self.safety_margin
                <= self.max_context_len)
