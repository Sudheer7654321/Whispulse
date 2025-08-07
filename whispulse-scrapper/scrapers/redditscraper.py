# scrapers/reddit_scraper.py
import praw
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

# Useful post keywords
KEYWORDS = [
    "prediction", "forecast", "price target", "bullish", "bearish",
    "breakthrough", "launch", "ai", "machine learning", "blockchain",
    "crypto", "bitcoin", "ethereum", "stock", "ipo", "merger", "acquisition",
    "upgrade", "innovation", "technology", "investment", "funding", "startup"
]

def is_useful_post(text):
    """Check if post contains any keyword from the list."""
    text_lower = text.lower()
    return any(keyword in text_lower for keyword in KEYWORDS)

def scrape_reddit(subreddits=None, limit=100):
    if subreddits is None:
        subreddits = ["CryptoCurrency", "stocks", "technology"]

    # Reddit API setup
    reddit = praw.Reddit(
        client_id="QFkFXNLU14ceOf223xD78w",
        client_secret="hKJ5MaTnmrQn9O429l5rrniLQSqPyA",
        user_agent="whispulse"
    )

    analyzer = SentimentIntensityAnalyzer()
    results = []

    for sub in subreddits:
        subreddit = reddit.subreddit(sub)
        for post in subreddit.hot(limit=limit):
            # Combine title and body
            text_content = f"{post.title} {post.selftext or ''}"

            # Filter out irrelevant posts
            if not is_useful_post(text_content):
                continue  # skip

            # Sentiment score
            sentiment = analyzer.polarity_scores(text_content)['compound'] * 10

            # Get image if available
            image_url = None
            if hasattr(post, "url") and (
                post.url.endswith((".jpg", ".png", ".jpeg", ".gif")) or "i.redd.it" in post.url
            ):
                image_url = post.url

            results.append({
                "title": post.title,
                "tag": sub,
                "description": post.selftext if post.selftext else None,
                "image": image_url,
                "post_url": f"https://www.reddit.com{post.permalink}",
                "score": round(sentiment, 2)
            })

    return results
