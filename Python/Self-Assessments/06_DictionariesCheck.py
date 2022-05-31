'''
Date: 25-02-2022
Author: Daniel
'''
# Import packages
import re

# Initialize set
original_set = {"Bulbasaur": "001", "Ivysaur": "002", "Venasaur": "003", "Charmander": "004", "Charmeleon": "005", "Charizard": "006"}
# Make a duplicate for editing
to_update = original_set

# Initialize key
key = ""

# While input is not quitted
while key.lower() != "quit":
    # Enter the name of a Pokemon
    key = input("Please input the name of a Pokemon or enter quit to exit: ")
    if key.lower() != "quit":
        # Enter operation to perform
        operation = input("What would you like to do with this entry (add/remove)? ")
        if re.search("^a", operation.lower()):
            if key.capitalize() in to_update.keys():
                print("Pokemon already exists")
            else:
                num = input("What three digit Pokedex number would you like to assign this Pokemon (e.g. 001)? ")
                to_update[key] = num
                print(to_update)
        if re.search("^r", operation.lower()):
            if key.capitalize() not in to_update.keys():
                print("Pokemon does not exist")
            else:
                to_update.pop(key)
                print(to_update)


print("")
print("The original set was:", original_set)
print("Your updated set is:", to_update)
            
