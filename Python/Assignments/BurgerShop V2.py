'''
Date: 26-05-2022
Author: Daniel
'''

###### WORKFLOW ######
# User is shown a menu
# User picks from menu
# User selection is added to Order
# If drink + side + burger is fulfilled, make into combo
# Final order printed out (items + total price)

import re
import collections

##############################
##          Classes         ##
##############################

class FoodItem:
    def __init__(self, n, p):
        self.name = n
        self.price = p

class Burger(FoodItem):
    # Burger requires condiments
    # Function can be called to append condiments to burger name (condiments should be in list format)
    def addCondiments(self, condiments):
        self.name = self.name + " with extra " + " and ".join(condiments)

class Drink(FoodItem):
    # Drink requires size
    def __init__(self, n, p, s):
        # Prepend drink size to name of ordered drink
        # Conditional price based on drink size
        if s.lower().startswith("l"):
            self.price = p + 1
            self.name = "Large" + " " + n
        elif s.lower().startswith("m"):
            self.price = p + 0.5
            self.name = "Medium" + " " + n
        else:
            self.price = p
            self.name = "Small" + " " + n

class Side(FoodItem):
    pass

class Order:
    def __init__(self):
        self.items = list()     # Create list to contain items
        self.price = 0          # Initialize price as 0
        self.is_combo = False    # Set True if order is a combo

    # Create a method to add items to the order
    def addItem(self, item):
        self.items.append(item)

    # Create a method to set the order to be a combo
    def setCombo(self):
        self.is_combo = True

    # Create a method to tally the price
    def calculateTotal(self):
        self.price = sum([item.price for item in self.items]) - 2 * self.is_combo

    # Change the print statement for the order
    def __str__(self):
        return "You ordered a {items} with the total tally coming up to ${price}"\
                .format(items = ", ".join([item.name for item in self.items]), price = self.price)


##############################
##       Dictionaries       ##
##############################

# Populating dictionaries for user perusal
# Formatting for ease of use, but in the case of duplicates, numerical tags could be prepended to names
burger_menu = {"Big Mac": 8, "McChicken": 5, "Filet O Fish": 5}
condiment_choices = ("Tabasco", "Mustard", "Ketchup", "Pickles", "BBQ Sauce", "Curry Sauce")
drink_menu = {"Root Beer": 3, "Coke Zero": 2.5, "Mountain Dew": 2}
sides_menu = {"Curly Fries": 3, "Waffle Fries": 3, "Shoestring Fries": 2, "Chicken Nuggets": 3.5}


##############################
##         Functions        ##
##############################

# Using a general function to get food selection from user
# General function used because each foodtype essentially goes through the same rigor
# Also allows user to select items in random order
def getFood(food_type):

    # Choose menu to display based on food_type
    if food_type.lower().startswith("b"):
        food_type_menu = burger_menu
        food_type = "burger"      # assignment for later use
    elif food_type.lower().startswith("d"):
        food_type_menu = drink_menu
        food_type = "drink"       # assignment for later use
    else:
        food_type_menu = sides_menu
        food_type = "side"        # assignment for later use

    # Display menu to user
    print("The following items are available:")
    for key, val in food_type_menu.items():
        print(key, ": $" + str(val))

    # Request for user input
    selected_food = input("What will you be having? ")
    # Get price of food from menu by matching selected food with one of the keys in the menu
    selected_food_price = [value for key, value in food_type_menu.items() if selected_food.lower() in key.lower()][0]
    # Fix the name of the food ordered
    selected_food = [key for key in food_type_menu.keys() if selected_food.lower() in key.lower()][0]

    # Create an instance depending on the food_type
    if food_type == "burger":
        food_item = Burger(selected_food, selected_food_price)
        # For burgers, get condiments
        print("Would you like added condiments for your burger? The following are available: \n{}".format(', '.join(condiment_choices)))
        # Initialize list to contain condiments
        condiments = []
        # Initialize while condition
        morecondiments = ""
        while morecondiments.lower() != "no":
            morecondiments = input("Please choose a condiment to add or press no to stop selecting condiments: ")
            if morecondiments.lower() != "no":
                condiments = condiments + [x for x in condiment_choices if re.search(morecondiments.lower(), x.lower())]
        # Add all the condiments to the burger name except the last item (which is 'no'), only if there were added condiments
        if len(condiments) != 1: 
            food_item.addCondiments(condiments)
    elif food_type == "drink":
        # Get drink size as well
        drink_size = input("What size would you want your drink? (Small/Medium (+$0.50)/Large (+$1)): ")
        food_item = Drink(selected_food, selected_food_price, drink_size)
    else:
        food_item = Side(selected_food, selected_food_price)

    return food_item


# This function helps to filter certain words from the user's order
def keywordSearch(string):

    # Based on whether keywords are found, a value for food type is assigned
    if re.search("burger", string):
        food_type = "burger"
    elif re.search("drink", string):
        food_type = "drink"
    elif re.search("side", string):
        food_type = "side"
    else:
        food_type = ""

    return food_type

# This function collects the order from the user
def getOrder():
    # Ask customer for what they want
    order_status = input("Welcome to Freddies. How may I help you? ").lower()
    # Initialize list for checking combo eligibility
    can_combo = []
    # Initialize order list
    order_list = []
    # Initialize order instance
    order = Order()

    # Run a search for keywords
    food_type = keywordSearch(order_status)
    # If a food type is found in the customer's order, proceed to append that food type to the eligibility list
    if food_type != "":
        can_combo.append(food_type)
    else:
        print("We have burgers, drinks and sides that you can choose from. \nPlease take your time in browsing our menu.")
        return

    # Get first food item
    order_list.append(getFood(food_type))

    # Ask customer if they want to order more, repeating until they say no
    order_status = "more"
    while order_status.lower() != "no":
        order_status = input("Would you like to order something else (burger/side/drink)? ")
        if order_status.lower() != "no":
            food_type = keywordSearch(order_status)
            can_combo.append(food_type)
            order_list.append(getFood(food_type))

    # Verify whether the order is possible to be an order
    counter = collections.Counter(can_combo)
    if counter["burger"] >= 1 and counter["drink"] >= 1 and counter["side"] >= 1:
        print("You have qualified for a combo meal, thus reducing the total cost of your meal by $2")
        order.setCombo()
        
    # Add all the items in the order_list to the order instance
    for item in order_list:
        order.addItem(item)

    # Calculate the total price
    order.calculateTotal()

    # Print out the order instance
    print(order)
    print("Thank you for your patronage. Please do wait a bit for your food.")


getOrder()
