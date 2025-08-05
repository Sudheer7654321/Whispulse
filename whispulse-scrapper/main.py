# main.py

import asyncio
import requests
from scrapers.redditscraper import scrape_reddit
from scrapers.twitterscraper import scrape_twitter

BACKEND_URL = "http://localhost:3000/trending"

async def main():
    reddit_results = scrape_reddit()
    twitter_results = await scrape_twitter("crypto", max_results=10)

    print("Twitter Results:", twitter_results)

    # Automatically send Reddit + Twitter to your backend:
    # for data in reddit_results + twitter_results:
    #     res = requests.post(BACKEND_URL, json=data)
    #     print(f"Sent: {data['title']} → {res.status_code}")

if __name__ == "__main__":
    asyncio.run(main())
