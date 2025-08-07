# main.py
import requests
from scrapers.redditscraper import scrape_reddit
from scrapers.twitterscraper import scrape_twitter

BACKEND_URL = "http://localhost:3000/trending"

def main():
    reddit_results = scrape_reddit()
    
    for data in reddit_results:
        res = requests.post(BACKEND_URL, json=data)
        print(f"Sent: {data['title']} → {res.status_code}")

if __name__ == "__main__":
    main()


