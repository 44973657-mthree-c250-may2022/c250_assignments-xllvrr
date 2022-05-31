'''
Date: 25-05-2022
Author: Daniel
'''

# Get user input
user_num = int(input("Please enter a number: "))

# Begin a count of length user number
for i in range(user_num):
    # If number is divisible by both 3 and 5, fizz buzz
    if i % 3 == 0 and i % 5 == 0:
        print("fizz buzz")
    # If number is divisible only by 3, fizz
    elif i % 3 == 0:
        print("fizz")
    # If number is divisible only by 5, buzz
    elif i % 5 == 0:
        print("buzz")
    # Else just print the number
    else:
        print(i)

# Last line (range stops 1 number before the provided value)
print("TRADITION!")
