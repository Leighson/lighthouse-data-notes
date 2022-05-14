import json
from lib.api import API, StartExamAuthorizationError, StartExamForbiddenError

class ExamLoader:

    def load(self, token):
        print(f"Contacting Server to Start Exam with token: {token}")
        
        try:
            json = API().start_exam(token)
            self.write_exam(json,token)
        except StartExamAuthorizationError as e:
            print('Token seems to be missing')
            print('Please make sure you enter it along with this command')
            print('python start_examp.py -t [<EXAM_TOKEN>]')
            print(f"Server Error: #{e}")
        except StartExamForbiddenError as e:
            print('Invalid token!')
            print('Please make sure you have started the exam from compass.')
            print(f"Server Error: #{e}")
        
        print('')
    
    def write_exam(self, exam, token):
        questions = exam['questions']
        
        print(f"Server Response: {len(questions)} Questions:")
        
        for q in questions:
            code_path = q['codePath']
            code_content = q['code']

            test_path = q['testPath']
            test_content = q['testCode']
            
            print(f'\tCreating Question {q["questionId"]}\t({q["maxScore"]} Points)\tAnswer file {code_path}')

            with open(code_path, 'w', encoding="utf-8") as f:
                f.write(code_content)

            with open(test_path, 'w', encoding="utf-8") as f:
                f.write(test_content)

        exam_data = {'exam_id': exam['examId'], 'token': token}

        with open('./.exam-data', 'w', encoding="utf-8") as f:
            f.write(json.dumps(exam_data))