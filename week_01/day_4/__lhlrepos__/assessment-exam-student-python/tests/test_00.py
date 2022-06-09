import pytest
from answers.question_00 import equal_slices

def test_on_returns_any_value():
    assert equal_slices(8,3,2) is not None

def test_on_returns_boolean():
    assert type(equal_slices(8,3,2)) == bool

def test_on_zero_recipients():
    assert equal_slices(8, 0, 2) == True

def test_on_true_case():
    assert equal_slices(8, 3, 2) == True

def test_on_false_case():
    assert equal_slices(8, 3, 3) == False