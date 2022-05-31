'''
Date: 25-05-2022
Author: Daniel
'''

import re

first_name = input("What is your first (given) name? ").lower()
team = ""

if re.search("^[a-d]", first_name):
    team = "Red Dragons"
elif re.search("^[e-h]", first_name):
    team = "Dark Wizards"
elif re.search("^[i-l]", first_name):
    team = "Moving Castles"
elif re.search("^[m-p]", first_name):
    team = "Golden Snitches"
elif re.search("^[q-t]", first_name):
    team = "Night Guards"
elif re.search("^[u-z]", first_name):
    team = "Black Holes"
    
print("\nYou're on the {}!\nAll the best at the games!".format(team))
