# import snscrape.modules.twitter as sntwitter
# from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

# # Reuse keyword list from Reddit
# KEYWORDS = [
#     "prediction", "forecast", "price target", "bullish", "bearish",
#     "breakthrough", "launch", "ai", "machine learning", "blockchain",
#     "crypto", "bitcoin", "ethereum", "stock", "ipo", "merger", "acquisition",
#     "upgrade", "innovation", "technology", "investment", "funding", "startup"
# ]

# def is_useful_post(text):
#     """Check if post contains any keyword from the list."""
#     text_lower = text.lower()
#     return any(keyword in text_lower for keyword in KEYWORDS)

# def scrape_twitter(keyword, max_results=10):
#     analyzer = SentimentIntensityAnalyzer()
#     results = []

#     query = f'{keyword} lang:en'
#     scraped_tweets = sntwitter.TwitterSearchScraper(query).get_items()

#     count = 0
#     for tweet in scraped_tweets:
#         if count >= max_results:
#             break

#         text = tweet.content

#         if not is_useful_post(text):
#             continue

#         sentiment = analyzer.polarity_scores(text)["compound"] * 10

#         results.append({
#             "title": text[:80] + "..." if len(text) > 80 else text,
#             "tag": keyword,
#             "description": text,
#             "image": None,  # snscrape doesn't provide images
#             "post_url": f"https://twitter.com/{tweet.user.username}/status/{tweet.id}",
#             "score": round(sentiment, 2)
#         })

#         count += 1

#     return results

# scrapers/twitterscraper.py
# scrapers/twitterscraper.py

from twscrape import API, gather
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

KEYWORDS = [
    "prediction", "forecast", "price target", "bullish", "bearish",
    "breakthrough", "launch", "ai", "machine learning", "blockchain",
    "crypto", "bitcoin", "ethereum", "stock", "ipo", "merger", "acquisition",
    "upgrade", "innovation", "technology", "investment", "funding", "startup"
]

def is_useful_post(text: str) -> bool:
    return any(keyword in text.lower() for keyword in KEYWORDS)

async def scrape_twitter(query: str = "crypto", max_results: int = 10):
    api = API()  # uses default accounts.db and anonymous or saved sessions
    await api.pool.load_accounts()

    tweets = await gather(api.search(query, limit=max_results))
    analyzer = SentimentIntensityAnalyzer()
    results = []

    for tweet in tweets:
        text = tweet.rawContent or tweet.content
        if not is_useful_post(text):
            continue

        sentiment = analyzer.polarity_scores(text)["compound"] * 10

        results.append({
            "title": text[:80] + "..." if len(text) > 80 else text,
            "tag": query,
            "description": text,
            "image": None,
            "post_url": tweet.url,
            "score": round(sentiment, 2)
        })

    return results
