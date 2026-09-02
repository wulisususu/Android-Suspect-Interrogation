from __future__ import annotations

import pytest
from pydantic import ValidationError

from app.runtime_settings import RuntimeSettings


def test_existing_single_backend_modes_remain_backward_compatible():
    assert RuntimeSettings(speaker_backend="xvector").speaker_backend == "xvector"
    assert RuntimeSettings(speaker_backend="eres2net_large").speaker_backend == "eres2net_large"


def test_compare_mode_requires_explicit_authoritative_backend():
    with pytest.raises(ValidationError, match="authoritative"):
        RuntimeSettings(speaker_backend="compare")


def test_compare_mode_accepts_xvector_or_eres2net_as_authoritative_backend():
    xvector = RuntimeSettings(
        speaker_backend="compare",
        speaker_authoritative_backend="xvector",
    )
    eres = RuntimeSettings(
        speaker_backend="compare",
        speaker_authoritative_backend="eres2net_large",
    )

    assert xvector.speaker_backend == "compare"
    assert xvector.speaker_authoritative_backend == "xvector"
    assert eres.speaker_authoritative_backend == "eres2net_large"


def test_compare_mode_rejects_compare_as_authoritative_backend():
    with pytest.raises(ValidationError, match="authoritative"):
        RuntimeSettings(
            speaker_backend="compare",
            speaker_authoritative_backend="compare",
        )
