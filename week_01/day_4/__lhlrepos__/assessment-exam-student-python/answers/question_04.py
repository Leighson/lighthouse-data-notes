"""
Create a function that takes an integer and returns True if it's divisible by 100, otherwise return False.

Examples:
    divisible(1) ➞ False

    divisible(1000) ➞ True

    divisible(100) ➞ True

"""
def divisible(integer):
    div = integer % 100
    return not(div)