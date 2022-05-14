import argparse
import glob
from lib.test_runner import TestRunner

parser = argparse.ArgumentParser()
parser.add_argument("-q", "--question", help="question number")

args = vars(parser.parse_args())

if not args['question']:
    print("A question number is required.")
    print("Please provide a question number like the following:")
    print("python test_question.py -q [<QUESTION_NUMBER>]")

else:
    try:
        TestRunner(question_number = args['question']).run()
    # general exception    
    except Exception as e:
        print(e)