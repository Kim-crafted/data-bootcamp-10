!pip install gazpacho

from requests import get
from time import sleep

base_url = "https://api.nytimes.com/svc/books/v3/lists/"
list_name = "hardcover-nonfiction"
api_key = "mWGx5iq2ZnsDbZvA1xEDQ9MmYixI9jPO"
url = f"{base_url}{list_name}.json?api-key={api_key}"
response = get(url)
response.status_code
response.json()

#Inspect key
if response.status_code == 200:
    data = response.json()
    if 'results' in data:
        print(data['results'].keys())
        print(data['results']['books'][0].keys())
else:
    print("Error")

#Data retrieval
if response.status_code == 200:
    data = response.json()
    nonfic = data['results']['books']
    book_rank = []

    for book in nonfic:
        rank = book['rank']
        title = book['title']
        author = book['author']
        description = book['description']
        results = [rank, title, author, description]
        book_rank.append(results)
        print(results)
        sleep(2)

else:
    print("Error: ", response.status_code)

#write file
import csv

header = ['rank', 'title', 'author', 'description']
with open('hardcover_nonfiction_ranking.csv', 'w') as file:
    writer = csv.writer(file)
    writer.writerow(header)
    writer.writerows(book_rank)

#View data roughly
!cat hardcover_nonfiction_ranking.csv

#Read csv
import pandas as pd
df = pd.read_csv('hardcover_nonfiction_ranking.csv')
df


