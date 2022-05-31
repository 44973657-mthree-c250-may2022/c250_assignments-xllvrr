'''
Date: 28-05-2022
Author: Daniel
'''

# Import modules
from random import seed
import random, string

class PasswordGenerator:
    def __iter__(self):
        self.seednum = 1234
        return self
    
    def __next__(self):
    # Include randomly-selected alphanumeric, special characters
        seed(self.seednum)
        self.seednum = self.seednum + int(random.random()*10)
        password = "".join(random.choices(string.ascii_letters + string.digits + string.punctuation, k=16)) 
        return password

# Generate at least five different passwords
passwords = PasswordGenerator()
password_iterator = iter(passwords)
passwordlist = []

# Allow user to choose password from generated list and display as selected password
for i in range(0, 5):
    passwordlist.append(next(password_iterator))
for i in range(0, 5):
    print(str(i+1) + ":", passwordlist[i])

passwordchoice = input("Which password would you like to choose (1-5)? ")

password = passwordlist[int(passwordchoice)-1]
print("Your chosen password is", password)
