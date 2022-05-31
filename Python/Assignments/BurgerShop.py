'''
Date: 26-05-2022
Author: Daniel
'''

import re

##############################
##          Classes         ##
##############################

# Implement food items
class FoodItem:
    def __init__(self, n, p):
        self.name = n
        self.price = p

class Burger(FoodItem):
    # requires kind and condiments
    def __init__(self, n, p, c):
        FoodItem.__init__(self, n, p)
        self.condiments = c

class Drink(FoodItem):
    # requires size and kind
    def __init__(self, n, p, s):
        FoodItem.__init__(self, n, p)
        self.size = s
        # increase the price if drink is upsized
        if re.search("^l", s.lower()):
            self.price = self.price + 1
        elif re.search("^m", s.lower()):
            self.price = self.price + 0.50

class Side(FoodItem):
    pass

# Order item
class Order:
    def __init__(self, c):
        self.items = list()
        self.price = 0
        # Check if order is a combo
        self.isCombo = c
        for item in self.items:
            self.price = self.price + item.price
        # Subtract $2 from the total price if customer chooses to go with a combo
        self.price = self.price - 2*self.isCombo

    '''
    def calculateTotal(self):
        for item in self.items:
            self.price = self.price + item.price
    '''

    def addItem(self, item):
        self.items.append(item)

    def __str__(self):
        order_items = [item.name for item in self.items]
        return "You ordered {} and the total tally comes up to ${}".format(", ".join(order_items), self.price)


##############################
##       Dictionaries       ##
##############################

burger_choices = {"Big Mac": 6, "McChicken": 4, "Filet O Fish": 4.5}
condiment_choices = ("Ketchup", "Mustard", "Tabasco")
drink_choices = {"Root Beer": 2, "Coke Zero": 2.2, "Mountain Dew": 2}
size_choices = {"Small": 0, "Medium": 0.50, "Large": 1}
sides_choices = {"Curly Fries": 3, "Straight-Cut Fries": 2, "Chicken Nuggets": 2.5}
 
##############################
##         Functions        ##
##############################

def getBurger():
    print("Please choose a burger from the following: ")
    for key, val in burger_choices.items():
        print(key, ": ${}".format(val))
    burgname = input("Please make your selection: ")
    burgprice = [value for key, value in burger_choices.items() if burgname.lower() in key.lower()]
    # burgprice = float(*burgprice)

    condiments = input("Would you like any specific condiments (y/n)? ")
    if re.search("^y", condiments.lower()):
        print("Please choose from the following: ")
        for condiment in condiment_choices:
            print(condiment)
        condiments = input("Please select the condiments you would like: ").split()
    else:
        condiments = "None"
        
    b = Burger(burgname, burgprice, condiments)
    #ask user for input and store it in burger object 
    return b
 
def getDrink():
    print("Please choose a drink from the following: ")
    for key, val in drink_choices.items():
        print(key, ": ${}".format(val))
    drinkname = input("Please make your selection or press enter to continue: ")

    # If customer has second thoughts on whether they want a drink
    if drinkname != "":
        drinkprice = [value for key, value in drink_choices.items() if drinkname.lower() in key.lower()]
        drinkprice = float(*drinkprice)

        drinksize = input("What size of drink would you like (small/medium/large)? ")

        d = Drink(drinkname, drinkprice, drinksize)
        #ask user for input and store it in drink object 
        return d
    else:
        pass
 
def getSide():
    #ask user for input and store it in side object 
    print("Please choose a side from the following: ")
    for key, val in sides_choices.items():
        print(key, ": ${}".format(val))
    sidename = input("Please make your selection or press enter to continue: ")

    # If customer has second thoughts on whether they want a side
    if sidename != "":
        sideprice = [value for key, value in drink_choices.items() if sidename.lower() in key.lower()]
        sideprice = float(*sideprice)

        s = Side(sidename, sideprice)
        #ask user for input and store it in drink object 
        return s
    else:
        pass
 
def takeOrder():
    #display order details
    print("Welcome to Freddies. Can I get your order?")
    isCombo = False
    burger = getBurger()
    # Ask customer if they want to continue ordering
    continue_order = input("You have chosen {}. \nWould you like to order a drink or side? ".format(burger.name)).lower()
    # Contineu order if yes, thank them if not
    if re.search("(^d|^y)", continue_order):
        drink = getDrink()
        continue_order = input("Would you like to get a side with that and make it a combo? It will be $2 off. ")
        if re.search("^y", continue_order):
            side = getSide()
            # Customer has turned their order into a combo
            isCombo = True
            order = Order(isCombo)
            order.addItem(burger)
            order.addItem(drink)
            order.addItem(side)
            print(order)
        else:
            order = Order(isCombo)
            order.addItem(burger)
            order.addItem(drink)
            print(order)
    elif re.search("(^s)", continue_order):
        side = getSide()
        continue_order = input("Would you like to get a drink with that and make it a combo? It will be $2 off. ")
        if re.search("^y", continue_order):
            drink = getDrink()
            # Customer has turned their order into a combo
            isCombo = True
            order = Order(isCombo)
            order.addItem(burger)
            order.addItem(side)
            order.addItem(drink)
            print(order)
        else:
            order = Order(isCombo)
            order.addItem(burger)
            order.addItem(side)
            print(order)
    else:
        order = Order(isCombo)
        order.addItem(burger)
        print(order)
    print("Thank you for your patronage. Please wait at the side for your order.")

 
##############################
##           Main           ##
##############################

takeOrder()
