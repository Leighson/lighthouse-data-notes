import pytest
from answers.question_03 import reverse_capitalize

def test_on_string():
    assert type(reverse_capitalize("input")) == str

def test_on_returns_string_same_length():
    assert len(reverse_capitalize("input")) == 5

def test_on_string_capitalize():
    assert reverse_capitalize("input").isupper() == True

def test_on_correct_answer():
    assert reverse_capitalize("input") == "TUPNI"
