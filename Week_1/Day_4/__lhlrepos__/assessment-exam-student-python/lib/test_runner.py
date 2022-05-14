import pytest
from lib.api import API, SubmissionError
from subprocess import Popen, PIPE
import datetime as dt
import json
import hashlib
from math import floor
import os 
import sys
import time


class TestRunner:

    def __init__(self, question_number):
        self.start_time = dt.datetime.now()
        self.question_number = int(question_number)

    
    def pad_number(self, number):
        if int(number) < 10:
            return f'0{number}'
        else:
            return str(number)

    
    def get_test_file_path(self):
        return f"tests/test_{self.pad_number(self.question_number)}.py"

    
    def load_exam_data(self):
        while not os.path.exists('./.exam-data'):
            time.sleep(1)
            
        with open('./.exam-data', 'r', encoding="utf-8") as f:
            self.exam_data = json.loads(f.read())


    def get_student_code(self):
        with open(f"answers/question_{self.pad_number(self.question_number)}.py", 'r', encoding="utf-8") as f:
            return f.read() 
    

    def get_test_file_hash(self):
        with open(self.get_test_file_path(), 'r', encoding="utf-8") as f:
            test_file_content = f.read()
        
        return hashlib.md5(test_file_content.encode()).hexdigest()

    
    def get_test_errors(self):
        if self.json_report['exitcode'] == 0:
            return []
        else:
            return [test_result for test_result in self.json_report['tests'] 
                    if test_result['outcome'] == 'failed']


    def get_request_body(self):
        dct = {
            'examId': self.exam_data['exam_id'],
            'questionNumber': self.question_number,
            'lintResults': None,
            'testResults': self.get_test_results(),
            'testFileHash': self.get_test_file_hash(),
            'studentCode': self.get_student_code(),
            'errors' : self.get_test_errors()
        }

        return dct

    
    def get_test_results(self):
        summary = self.json_report['summary']
        total = summary['total'] if summary.get('total') else 0
        failed = summary['failed'] if summary.get('failed') else 0
        collected = summary['collected'] if summary.get('collected') else 0
        passes = total - failed
        pending = total - collected

        dct = {
            'suites': 1,
            'tests': total,
            'passes': passes,
            'pending': pending,
            'failures': failed,
            'start': str(self.start_time),
            'end': str(self.end_time),
            'duration' : self.json_report['duration']
        }

        return dct


    def print_results(self,results):
        print('Overall Score')
        print('------------')

        questions = results['scores']
        for q in questions:
            print(f'Q{q["questionNumber"]}. {int(q["score"])}/{int(q["maxScore"])}')


        time_remaining = float(results['remainingTime'])
        if time_remaining > 0:
            hours = floor(time_remaining / 60)
            minutes = floor(time_remaining % 60)

            print(f"Time Remaining: {hours}h{minutes}m")

        else:
            print('Time Remaining: None (Submission still accepted)')
    

    def get_json_report(self):
        while not os.path.exists('.report.json'):
            time.sleep(1)

        with open('.report.json', 'r', encoding="utf-8") as f:
            return json.loads(f.read())

    
    def print_pytest_traceback(self):
        print(self.stdout.decode('utf-8'))

    
    def cleanup(self):
        if os.path.exists('.report.json'):
            os.remove('.report.json')


    def run(self):
        self.load_exam_data()

        process = Popen(['pytest', 
                         self.get_test_file_path(), 
                         '--json-report',
                         '--tb=short',
                         '--color=yes'], stdout=PIPE, stderr=PIPE)
        self.stdout, self.stderr = process.communicate()
        self.json_report = self.get_json_report()
        self.end_time = dt.datetime.now()
        self.request_body = self.get_request_body()

        try:
            self.res = API().submit_results(request_body = self.request_body,
                                        exam_id = self.exam_data['exam_id'], 
                                        exam_token = self.exam_data['token'])

            self.print_pytest_traceback()
            self.print_results(results=self.res)
        
        except SubmissionError as e:
            print(e)

        self.cleanup()

