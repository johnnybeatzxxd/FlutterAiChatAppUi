import requests 


def login(username,password):
    url = 'https://mychatapp--johnnybeatz1.repl.co/login/'  # Replace with your server's address
    data = {'username': username, 'password': password}
    response = requests.post(url, json=data)

    if response.status_code == 200:
        token = response.json()['token']
        print("Login successful! Token:", token)
    else:
        print("Login failed:")


def signup():
    url = 'https://mychatapp--johnnybeatz1.repl.co/signup/' 
    data = {'username': 'johnnybeatzzzxzyyyy', 'email': 'youremail@example.com', 'password': '12345678'}
    response = requests.post(url, json=data)
    
    if response.status_code == 201:
        token = response.json()['token']
        print("Signup successful! Token:", token)
    else:
        print("Signup failed:",)

signup()