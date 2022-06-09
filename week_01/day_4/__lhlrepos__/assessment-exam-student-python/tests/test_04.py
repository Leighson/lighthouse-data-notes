import pytest
from answers.question_04 import divisible

def test_on_boolean():
    assert type(divisible(100)) == bool

def test_on_false():
    assert divisible(1) == False

def test_on_true():
    assert divisible(100) == True