# Importing packages
import re
import sys

#################################################
###            Customer Selections            ###
#################################################

# Query Size of Cup
# Options: Small, Medium, Large
cup_size = input("Would you like a small, medium or large? ").lower()

# Query Type of Coffee
# Options: Brewed, Espresso, Cold Brew
coffee_type = input("Would you like brewed coffee, an espresso or a cold brew? ").lower()

# Query Choice of Flavoring (if applicable)
# Options: None, Hazelnut, Vanilla, Caramel
flavoring = input("Would you like any flavoring to go with that (Y/N)? ").lower()
if re.search("^y", flavoring):
    flavoring = input("We have the following flavorings: \
                      \nHazelnut, Vanilla and Caramel \
                      \nWhich would you prefer? ")


#################################################
###           Cup Price Calculations          ###
#################################################

# Small: $2, Medium: $3, Large: $4
if re.search("^s", cup_size):
    cup_price = 2
elif re.search("^m", cup_size):
    cup_price = 3
elif re.search("^l", cup_size):
    cup_price = 4
else:
    print("Cup size provided was not in the possible selections, please try again")
    sys.exit()

# Brewed: +$0, Espresso: +$0.50, Cold Brew: +$1
if re.search("^brew", coffee_type):
    cup_price = cup_price
elif re.search("^esp", coffee_type):
    cup_price = cup_price + 0.50
elif re.search("^cold", coffee_type):
    cup_price = cup_price + 1
else:
    print("Coffee type provided was not in the possible selections, please try again")
    sys.exit()

# Flavoring: +$0.50
if re.search("^n", flavoring):
    cup_price = cup_price
elif re.search("hazel|van|car", flavoring):
    cup_price = cup_price + 0.50
else:
    print("Flavoring chosen does not exist in the possible selections, please try again")
    sys.exit()

# Display Order
# Display Total Cost, Total Cost + Tip (2dp)
if re.search("^n", flavoring):
    print("\nYour order was a {} {} with no flavorings".format(cup_size, coffee_type))
else:
    print("\nYour order was a {} {} with {} flavoring".format(cup_size, coffee_type, flavoring))
    
print("Your order cost ${}, and after tips the final tally is ${}"
      .format("{:.2f}".format(cup_price), "{:.2f}".format(cup_price*1.15)))
