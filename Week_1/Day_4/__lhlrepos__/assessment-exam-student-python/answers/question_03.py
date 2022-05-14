"""
Create a function that takes a string of lowercase characters and returns that string reversed and in upper case.

Examples:
    reverse_capitalize("abc") ➞ "CBA"

    reverse_capitalize("hellothere") ➞ "EREHTOLLEH"

    reverse_capitalize("input") ➞ "TUPNI"
"""

def reverse_capitalize(string):
    rev_string = string[::-1].upper()
    return rev_string