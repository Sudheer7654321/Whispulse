Whispulse
Whispulse is an AI-powered trend tracking and sentiment analysis platform that monitors stocks, crypto, memes, news, and tech topics in real-time across multiple platforms like Reddit, X (Twitter), and Discord.

It combines web scraping, natural language processing, and intelligent ranking to deliver short, actionable insights for users who want to stay ahead of trends.

Features
Multi-Platform Data Collection
Scrapes Reddit, X, and Discord in real time for fresh trends.

AI-Powered Summarization
Uses GPT-based models to turn long discussions into concise summaries.

Sentiment Analysis
Measures public mood using sentiment scoring models like VADER or transformers.

Trend Scoring
Ranks topics based on volume, engagement, and sentiment.

Custom Alerts
Users can subscribe to alerts for keywords or topics.

Responsive UI
Built with Flutter to work seamlessly on both mobile and web.

Tech Stack
Frontend:

Flutter

Dart

Backend:

Node.js for API and business logic

Python for scraping and AI processing

Docker for containerized execution

Data & AI:

VADER Sentiment

Hugging Face Transformers

GPT-powered summarization

Google Cloud / Firebase

Project Structure
Whispulse/

whispulse-frontend/ → Flutter app

whispulse-backend/ → Node.js API and business logic

whispulse-scrapper/ → Python scrapers for Reddit, X, and Discord

scrapers/ → Source-specific scraping logic

utils/ → Data cleaning, storage, and sentiment analysis helpers

config.py → API keys and constants

main.py → Script entry point

Getting Started
Clone the repository:
git clone https://github.com/YOUR_USERNAME/Whispulse.git

Backend Setup (Node.js + Python):

Install Node.js dependencies with npm install

Install Python dependencies with pip install -r requirements.txt

Frontend Setup (Flutter):

Run flutter pub get to fetch dependencies

Create .env files in the backend folders for credentials like:

Reddit API keys

OpenAI API key

Example Output
Topic: Flutter 3.19 release
Summary: Developers praise new performance boosts and faster build times.
Sentiment: Positive (0.82 score)
Trend Score: High

Roadmap
Live visualizations for trends

More scraping sources (Telegram, YouTube)

Advanced filtering options

Export trends as PDF reports

Contributing
Fork the repository

Create a branch for your feature

Commit and push changes

Submit a pull request

License
MIT License. See LICENSE file for details.

Contact
Author: Sudheer Kondamuri
GitHub: https://github.com/Sudheer7654321
