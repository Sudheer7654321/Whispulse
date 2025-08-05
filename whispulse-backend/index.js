import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import admin from 'firebase-admin';
import { readFileSync } from 'fs';

dotenv.config();
const app = express()
app.use(cors());
app.use(express.json());

// Firebase Admin init
const serviceAccount = JSON.parse(
  readFileSync('./serviceAccountKey.json', 'utf8')
);
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const db = admin.firestore()

// Health check endpoint
app.get('/', (req, res) => {
    console.log('get')
  res.json({ status: 'WhispPulse API is running 🚀' });
});

// Get trending topics
app.get('/trending', async (req, res) => {
  try {
    const snapshot = await db.collection('trending')
      .orderBy('score', 'desc')
      .limit(20)
      .get();

    const topics = snapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data()
    }));

    res.json(topics);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch trending topics' });
  }
});
app.post('/trending', async (req, res) => {
  try {
    const { title, tag, description, image, post_url, score } = req.body;

    // Validate incoming data
    if (!title || !tag || score === undefined) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    // Save to Firestore
    await db.collection('trending').add({
      title,
      tag,
      description,
      image,
      post_url,
      score,
      timestamp: admin.firestore.FieldValue.serverTimestamp()
    });

    res.status(201).json({ message: 'Topic added successfully 🚀' });

  } catch (e) {
    console.error('Error adding topic:', e);
    res.status(500).json({ error: 'Failed to add topic' });
  }
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`API running on port ${PORT}`));
