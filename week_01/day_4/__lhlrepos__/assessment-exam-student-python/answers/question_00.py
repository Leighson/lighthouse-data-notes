"""
Create a function that determines whether or not it’s possible to split a pie fairly given these three parameters:
  - Total number of slices
  - Number of recipients
  - How many slices each person gets 

Form of the function:
    equal_slices(total_ slices, no_recipients, slices_each)

Examples:
    equal_slices(11, 5, 2) ➞ True
    5 people x 2 slices each = 10 slices < 11 slices 

    equal_slices(11, 5, 3) ➞ False
    5 people x 3 slices each = 15 slices > 11 slices


    equal_slices(8, 3, 2) ➞ True

    equal_slices(8, 3, 3) ➞ False

    equal_slices(24, 12, 2) ➞ True

Notes:
 - Return True if there are zero people.
 - It's fine not to use the entire pie.
 - All parameters are integers
"""

def equal_slices(total_slices, no_recipients, slices_each):
    
    if no_recipients == 0:
        return True
    elif no_recipients * slices_each <= total_slices:
        return True
    else:
        return False