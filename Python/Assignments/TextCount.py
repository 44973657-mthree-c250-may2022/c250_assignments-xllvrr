# Import Packages
import string
import re

# Initialize Text
s = input("Would you like to input a text? ")
if bool(s):
    s = """Imagine a vast sheet of paper on which straight Lines, Triangles, Squares, Pentagons, Hexagons, and other figures, instead of remaining fixed in their places, move freely about, on or in the surface, but without the power of rising above or sinking below it, very much like shadows - only hard and with luminous edges - and you will then have a pretty correct notion of my country and countrymen. Alas, a few years ago, I should have said "my universe": but now my mind has been opened to higher views of things."""

# Normalize Text
s_lower = s.lower()

# Split String
s_split = s_lower.split(" ")

# Get String Length
print("Number of words in the text is {}".format(len(s_split)))

# Remove Puncutation
def remove_punc(word):
    clean_string = word.translate(str.maketrans('', '', string.punctuation))
    return clean_string
s_clean = [remove_punc(word) for word in s_split]
print("Number of words after removing punctuation is {}".format(len(s_clean)))

# Get List of Unique Words
s_unique = []
for word in s_clean:
    if word not in s_unique:
        s_unique.append(word)

# Get Number of Unique Words
print("Number of unique words is {}".format(len(s_unique)))

# Get Frequency of Words
s_freq = dict()
for word in s_clean:
    if word not in s_freq.keys():
        s_freq.update({word: 1})
    else:
        s_freq[word] = s_freq[word] + 1
print("The following is the frequency of words in the text")
print(s_freq)

# Ask for user input for a text
word_to_search = input("\nWould you like to search for a particular word (Y/N)? ")
if re.search("^y", word_to_search.lower()):
    word_to_search = input("What is the word you would like to search for?: ")
    s_freq[word_to_search.lower()]


# Sort dictionary
do_sort = input("\nHow would you like to sort the dictionary (alphabetically/highest frequency/lowest frequency/no) ")
if re.search("^alpha", do_sort.lower()):
    for key in sorted(s_freq):
        print("{}: {}".format(key, s_freq[key]))
elif re.search("^high", do_sort.lower()):
    for key in sorted(s_freq, key=s_freq.get, reverse=True):
        print("{}: {}".format(key, s_freq[key]))
elif re.search("^low", do_sort.lower()):
    for key in sorted(s_freq, key=s_freq.get, reverse=False):
        print("{}: {}".format(key, s_freq[key]))
