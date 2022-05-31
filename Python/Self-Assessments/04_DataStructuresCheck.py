'''
Date: 25-05-2022
Author: Daniel
'''

# Initialize tuple
my_tuple = (1,2,3,4,5,6,7,8,9,10,11,12)

# Split tuple in three separate lists of length 4
list_start = list(my_tuple[:4])
list_end = list(my_tuple[-4:])
list_mid = list(my_tuple[4:-4])

# Reverse the list
list_start = list_start[::-1]
list_end = list_end[::-1]
list_mid = list_mid[::-1]
