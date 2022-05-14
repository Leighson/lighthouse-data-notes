import pytest
from answers.question_02 import count_unique_chars

def test_on_integer():
    assert type(count_unique_chars("apple", "play")) == int

def test_on_empty_string():
    assert count_unique_chars("", "") == 0

def test_on_almost_right_answer():
    assert count_unique_chars("sore", "zebra") <= 9

def test_on_right_answer():
    assert count_unique_chars("sore", "zebra") == 7 


