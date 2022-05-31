'''
Date: 26-05-2022
Author: Daniel
'''

import string

# Create function that accepts string as user input
def countWords():
    user_string = input("Please enter a piece of text: ").lower() 

# Remove punctuation
    user_string.translate(str.maketrans('','',string.punctuation))

# Split words
    split_string = user_string.split()

# Identify unique words and add words to dictionary, counting frequency
    unique_words = {}
    for word in split_string:
        if word in unique_words.keys():
            unique_words[word] = unique_words[word] + 1
        else:
            unique_words[word] = 1

# Display dictionary to user with user friendly message
    print("\nHere's the breakdown of words in your provided text:\n{}".format(unique_words))

countWords()
