import requests

def signup():
    payload = {"username": "adam1", "password": "Pass1234!", "email": "adam@email.com"}

    response = requests.post('https://cheatchatapp1.onrender.com/signup', json=payload)

    print(response.text)



def login(username, password):
    response = requests.post('https://cheatchatapp1.onrender.com/login', json={"username": username, "password": password})
    print(response.content)
    return response.json()

def test_token(token):
  headers = {'Authorization': f"Token {token}"}
  response = requests.get("https://cheatchatapp1.onrender.com/test_token", headers=headers)
  print(response.content)


def chat(messages):
  headers = {'Authorization': "Token da1fc09c466130048abecd5671319bd97df44692",}
  payload = {"messages":messages}
  response = requests.post('https://cheatchatapp1.onrender.com/chat', headers=headers,json=payload)
  print(response.status_code)


#chat([{'role': 'user', 'parts': 'hi'},{'role': 'model', 'parts': 'hi'},{'role':"user","parts":"whats wrong!"}])
#test_token('da1fc09c466130048abecd5671319bd97df44692')
login(username="user",password="pass")