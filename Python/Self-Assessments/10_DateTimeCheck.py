'''
Date: 28-05-2022
Author: Daniel
'''

from datetime import datetime, timedelta

def timeChange():
# Include weeks, days, hours, minutes and seconds
# Specify addition or subtraction between two input times
# Output as:
# Days, Hours, Minutes, Seconds
# Days
# Hours
# Minutes
# Seconds
    date1 = input("Please input a date in the following format (DD HH:MM:SS): ")
    date1 = datetime.strptime(date1, "%d %H:%M:%S")
    delta1 = timedelta(days = date1.day, hours = date1.hour, minutes = date1.minute, seconds = date1.second)
    date2 = input("Please input another date in the following format (DD HH:MM:SS): ")
    date2 = datetime.strptime(date2, "%d %H:%M:%S")
    delta2 = timedelta(days = date2.day, hours = date2.hour, minutes = date2.minute, seconds = date2.second)
    mode = input("Would you like to add or subtract the dates?: ")

    if mode.lower().startswith("a"):
        result = delta1 + delta2
    else:
        result = abs(delta1 - delta2)

    print(result.days // 7, "weeks", \
          result.days % 7, "days", result.seconds // 3600, "hours",\
          (result.seconds % 3600) // 60, "minutes",\
          (result.seconds % 3600) % 60, "seconds")
    print(result.days / 7, "weeks")
    print(result.days, "days")
    print(result.days * 24 + result.seconds / 3600, "hours")
    print(result.days * 24 * 60 + result.seconds / 60, "minutes")
    print(result.days * 24 * 60 * 60 + result.seconds, "seconds")


def dateChange():
# Include days, hours, minutes, seconds
# Specify either addition or substraction
# Output as Month (Name) DD, YYYY, HH:MM:SS A/PM
    date = input("Please input a date in the following format (DD-MM-YYYY H:M:S): ")
    date = datetime.strptime(date, "%d-%m-%Y %H:%M:%S")
    diff = input("Please enter the difference in time in the following format (D H:M:S): ")
    daydiff = diff.split()[0]
    timediff = diff.split()[1]
    mode = input("Would you like to add or subtract the time from the date? ")

    if mode.lower().startswith("a"):
        newdate = date + timedelta(days=int(daydiff), hours=int(timediff.split(":")[0]),\
                                   minutes=int(timediff.split(":")[1]), seconds=int(timediff.split(":")[2]))
    else:
        newdate = date - timedelta(days=int(daydiff), hours=int(timediff.split(":")[0]),\
                                   minutes=int(timediff.split(":")[1]), seconds=int(timediff.split(":")[2]))

    print("It will be", newdate.strftime("%A, %B %d, %Y, %I:%M:%S %p"))

def ageChange():
# Years Months Days
# Months Days
# Weeks Days
# Days
# Hours
# Minutes
# Seconds
    startdate = input("Please input a starting date in the following format (DD-MM-YYYY HH:MM:SS): ")
    startdate = datetime.strptime(startdate, "%d-%m-%Y %H:%M:%S")
    enddate = input("Please input an end date in the following format (DD-MM-YYYY HH:MM:SS): ")
    enddate = datetime.strptime(enddate, "%d-%m-%Y %H:%M:%S")

    difference = enddate - startdate
    print("")
    print(difference.days // 365, "years",\
          (difference.days % 365) // 30, "months",
          (difference.days % 365) % 30, "days")
    print(difference.days // 30, "months",
          difference.days % 30, "days")
    print(difference.days // 7, "weeks",
          difference.days % 7, "days")
    print(difference.days, "days")
    print(difference.days * 24 + difference.seconds / 3600, "hours")
    print(difference.days * 24 * 60 + difference.seconds / 60, "minutes")
    print(difference.days * 24 * 60 * 60 + difference.seconds, "seconds")
