import requests
import json

API_HOST = "https://lighthouse-proctologist.herokuapp.com"
EXAM_PATH = f"{API_HOST}/api/v2/exams"

class StartExamAuthorizationError(Exception):
    pass
class StartExamForbiddenError(Exception):
    pass
class SubmissionError(Exception):
    pass

class API:
    
    def start_exam(self, exam_token):
        headers = {'Authorization': f'Bearer {exam_token}'}
        r = requests.get(EXAM_PATH, headers=headers)
        
        json = r.json()
        
        if r.status_code == 401:
            raise StartExamAuthorizationError(json['error'])
        
        if r.status_code == 403:
            raise StartExamForbiddenError(json['error'])
        
        return json
    
    
    def submit_results(self, request_body, exam_id, exam_token):
        url = f"{EXAM_PATH}/{exam_id}"
        
        headers = {'Authorization': f'Bearer {exam_token}',
                   'Content-Type': 'application/json'}
        
        body = json.dumps(request_body)
        
        r = requests.post(url, headers=headers, data=body)
        
        if r.status_code != 200:
            raise SubmissionError(body)
        
        return r.json()