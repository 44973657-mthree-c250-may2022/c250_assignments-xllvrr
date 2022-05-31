'''
Date: 26-02-2022
Author: Daniel
'''

# Create class called SimpleCalculator that takes two operands

class SimpleCalculator:

    # Initialize the num1 and num2 variables
    def __init__(self, num1, num2):
        self.num1 = num1
        self.num2 = num2

    # Addition operation
    def add(self):
        doOperate = input("Would you like to add the two numbers (yes/quit)? ")
        if doOperate.lower() == "quit":
            print("Understood. Have a nice day!")
        else:
            print("The sum of the two numbers is", self.num1 + self.num2)

    # Subtraction operation
    def subtract(self):
        doOperate = input("Would you like to subtract the two numbers (yes/quit)? ")
        if doOperate.lower() == "quit":
            print("Understood. Have a nice day!")
        else:
            print("The difference of the two numbers is", self.num1 - self.num2)

    # Multiplication operation
    def multiply(self):
        doOperate = input("Would you like to multiply the two numbers (yes/quit)? ")
        if doOperate.lower() == "quit":
            print("Understood. Have a nice day!")
        else:
            print("The product of the two numbers is", self.num1 * self.num2)

    # Division operation
    def divide(self):
        doOperate = input("Would you like to divide the two numbers (yes/quit)? ")
        if doOperate.lower() == "quit":
            print("Understood. Have a nice day!")
        else:
            print("The result of dividing the two numbers is", self.num1 / self.num2)


# Create an object and try the operations
testCalc = SimpleCalculator(4,5)

testCalc.add()
testCalc.subtract()
testCalc.multiply()
testCalc.divide()
