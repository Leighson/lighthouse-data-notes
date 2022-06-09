import pytest
from answers.question_01 import equal_slices

def test_on_returns_tuple():
    assert type(equal_slices(11, 5, 2)) == tuple

def test_on_tuple_length():
    assert len(equal_slices(11, 5, 2)) == 2

def test_on_zero_recipients():
    assert equal_slices(8, 0, 2) == (True, 8)

def test_on_true():
    assert equal_slices(8, 3, 2)[0] == True

def test_on_second_element_int():
    assert type(equal_slices(8, 3, 2)[1]) == int

def test_on_second_element_correct():
    assert equal_slices(8, 3, 2)[1] == 2 

def test_on_second_element_zero():
    assert equal_slices(24, 12, 2)[1] == 0

def test_on_false():
    assert equal_slices(8, 3, 3)[0] == False

def test_on_second_element_none():
    assert equal_slices(8, 3, 3)[1] is None     
