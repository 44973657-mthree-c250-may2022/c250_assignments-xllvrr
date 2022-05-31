'''
Date: 24-05-2022
Author: Daniel
'''

# Get first name, last name, phone number and birth year
first_name = input("Please provide your first name: ")
last_name = input("Please provide your last name: ")
phone_no = input("Please provide your phone number: ")
birth_year = input("Please provide your birth year: ")

# Output to user
print("\nHello {firstname}, let's check your details!\n\
Your full name is {firstname} {lastname}\n\
Your current phone number is {phoneno}\n\
And you were born in {yearborn}\n\
We hope your details are all correct. If not, please try again."
      .format(firstname=first_name, lastname=last_name, phoneno=phone_no, yearborn=birth_year))
