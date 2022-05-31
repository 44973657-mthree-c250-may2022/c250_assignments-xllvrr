'''

Author: Daniel
'''

import json
from collections import Counter
from pprint import pprint

# Access JSON
with open('./Movies.json', 'r') as jsonfile:
    movies = json.load(jsonfile)

# Number of Movies Included
print("There are", len(movies), "movies in the dataset")

# Year of Production: A Separation
for row in movies:
    if row['title'] == "A Separation":
        print("A Separation was produced in", row['year'])

# Number of Movies directed by Martin Scorsese
martinmovies = 0
for row in movies:
    if "Martin Scorsese" in row['directors']:
        martinmovies += 1
print("Martin Scorsese has directed", martinmovies, "movies")

# What movie has the longest runtime
longestmovie = ""
longestruntime = 0
for row in movies:
    if int(row['runtime']) > longestruntime:
        longestruntime = int(row['runtime'])
        longestmovie = row['title']
print("The longest movie in the dataset is", longestmovie, "at", str(longestruntime), "minutes")

# How many movies of each genre
genrecollate = []
for row in movies:
    for genre in row['genres']:
        genrecollate.append(genre.strip())
genrecounter = Counter(genrecollate)
pprint(genrecounter)

# Which genre has most movies
genremost = ""
genremostnum = 0
for key, val in genrecounter.items():
    if val > genremostnum:
        genremost = key
        genremostnum = val
print("The genre with the most movies at", genremostnum, "is", genremost.capitalize())

# Which movies were made in the 2010s?
post2k = []
for row in movies:
    if int(row['year']) >= 2010:
        post2k.append(row['title'])
pprint(post2k)

# Average length of movies in 2000s
post2klength = []
for row in movies:
    if int(row['year']) >= 2000:
        post2klength.append(int(row['runtime']))
print("The average runtime for movies after 2000 has been",\
      round(sum(post2klength)/len(post2klength)), "minutes")
