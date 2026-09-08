import pytest

from moss_worker.context_budget import ContextBudget


def test_exact_context_boundary_preserves_reserve_and_safety():
    budget = ContextBudget()
    assert budget.fits(10752)
    assert not budget.fits(10753)
    assert budget.output_reserve == 5120
    assert budget.safety_margin == 512


def test_4096_context_cannot_even_hold_output_reserve():
    assert not ContextBudget(max_context_len=4096).fits(0)


@pytest.mark.parametrize('context', [32768, 16385, 0, -1, 16384.0, True, None])
def test_context_must_be_positive_integer_within_verified_16384_cap(context):
    with pytest.raises(ValueError):
        ContextBudget(max_context_len=context)


@pytest.mark.parametrize('count', [-1, 1.5, None, True])
def test_invalid_exact_counts_are_rejected(count):
    with pytest.raises(ValueError):
        ContextBudget().fits(count)
