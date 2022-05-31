'''
Date: 29-05-2022
Author: Daniel
'''

import re
import json
from collections import Counter
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
lemmatizer = WordNetLemmatizer()

# Convert Text File to String
def readTextFile(filepath):
    with open(filepath, "r") as f:
        textfile = f.read()
        f.close()
    return textfile

# Split String into Words
def splitText(text):
    # Split on punctuation
    text = re.split('[^a-zA-Z0-9]', text)
    # Convert to lowercase
    text = [word.lower() for word in text]
    # Filter out empty strings
    text = list(filter(None, text))
    return text

# Exclude Stop Words (e.g. the, and, a) using nltk module
def cleanText(textlist):
    cleantext = [word for word in textlist if not word in stopwords.words('english')]
    return cleantext

# Lemmatize Words (e.g. walk, walked, walking = walk)
def lemmatizeText(textlist):
    lemmatizedtext = [lemmatizer.lemmatize(word) for word in textlist]
    return lemmatizedtext

# Count Words
def getWordFrequency(textlist):
    wordfreq = Counter(textlist)
    return wordfreq

# Export to JSON
def saveWordFrequency(freqdict, filepath):
    with open(filepath, "w") as outfile: 
        json.dump(freqdict, outfile, indent=4)

# Run Functions
text = readTextFile("data/SampleText.txt")
words = splitText(text)
words_clean = cleanText(words)
words_lemmatized = lemmatizeText(words_clean)
word_count = getWordFrequency(words_lemmatized)
saveWordFrequency(word_count, "data/WordFreq.json")
