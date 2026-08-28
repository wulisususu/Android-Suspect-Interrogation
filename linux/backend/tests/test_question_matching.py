from app.services.question_matching import (
    QuestionCandidate,
    QuestionMatchStatus,
    is_question_utterance,
    match_question,
)


def test_operational_instruction_is_not_treated_as_template_question():
    assert is_question_utterance("继续说。") is False
    assert is_question_utterance("声音大一点。") is False


def test_real_police_question_is_eligible_for_matching():
    assert is_question_utterance("你什么时候到达现场的？") is True
    assert is_question_utterance("当时是谁和你一起去的") is True


def test_regex_match_returns_one_existing_template_question():
    questions = [
        QuestionCandidate(
            id="Q08",
            text="你何时到达案发现场？",
            patterns=(r"(何时|什么时候|几点).*(到达|到).*(现场)",),
        ),
        QuestionCandidate(
            id="Q09",
            text="当时与你一起的人员是谁？",
            patterns=(r"(谁|什么人).*(一起|同行)",),
        ),
    ]

    result = match_question("你第二次是什么时候到现场的？", questions)

    assert result.status is QuestionMatchStatus.MATCHED
    assert result.matched_question_ids == ("Q08",)
    assert result.source_text == "你第二次是什么时候到现场的？"


def test_ambiguous_regex_match_never_auto_selects_one_question():
    questions = [
        QuestionCandidate(id="Q01", text="何时到现场", patterns=(r"什么时候.*现场",)),
        QuestionCandidate(id="Q02", text="何时返回现场", patterns=(r"什么时候.*现场",)),
    ]

    result = match_question("你什么时候又回到现场的？", questions)

    assert result.status is QuestionMatchStatus.AMBIGUOUS
    assert result.matched_question_ids == ("Q01", "Q02")


def test_compound_police_utterance_is_kept_as_one_source_event():
    questions = [
        QuestionCandidate(
            id="Q12",
            text="你为什么返回现场？",
            patterns=(r"(返回|回).*现场.*为什么.*(返回|回|去)",),
        )
    ]
    utterance = "你第二次什么时候回现场的，当时为什么又回去？"

    result = match_question(utterance, questions)

    assert result.source_text == utterance
    assert result.status is QuestionMatchStatus.MATCHED
    assert result.matched_question_ids == ("Q12",)


def test_non_question_never_attempts_template_match():
    questions = [QuestionCandidate(id="Q01", text="继续说明情况", patterns=(r"继续说",))]

    result = match_question("继续说。", questions)

    assert result.status is QuestionMatchStatus.NOT_QUESTION
    assert result.matched_question_ids == ()


def test_invalid_regex_does_not_break_other_candidates():
    questions = [
        QuestionCandidate(id="bad", text="bad", patterns=(r"(",)),
        QuestionCandidate(id="good", text="何时到现场", patterns=(r"什么时候.*现场",)),
    ]

    result = match_question("你什么时候到现场的？", questions)

    assert result.status is QuestionMatchStatus.MATCHED
    assert result.matched_question_ids == ("good",)


def test_plain_statement_with_question_word_inside_is_not_promoted_by_suffix_only():
    assert is_question_utterance("我不知道什么时候到的。") is False
    assert is_question_utterance("我不清楚是谁一起去的。") is False
    assert is_question_utterance("我记不清几点到现场。") is False
    assert is_question_utterance("我没注意他为什么离开。") is False
