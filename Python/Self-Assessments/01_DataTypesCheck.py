'''
Date: 24-05-2022
Author: Daniel
'''

import re

# Get user information
# First Name, Last Name, City of Residence, Hourly Wage, Number of Hours Worked / Week

first_name = input("Please input your first name: ").capitalize()
last_name = input("Please input your last name: ").capitalize()
city_reside = input("Please input your city of residence: ").capitalize()
hourly_wage = input("Please input your hourly wage: ")
weekly_hours = int(input("How many hours do you work per week? "))

# Make sure hourly wage is only numbers
hourly_wage = int(re.search("[0-9]*", hourly_wage).group())

# Present data collected
print("\nHello {} {}! Hope you're doing well!\n\
Hopefully the weather in {} is alright\n\
Based on the information provided, you earn {}$ per week, {}$ a month and {}$ a year"
      .format(first_name, last_name, city_reside, hourly_wage * weekly_hours, hourly_wage * weekly_hours * 4, hourly_wage * weekly_hours * 52))
