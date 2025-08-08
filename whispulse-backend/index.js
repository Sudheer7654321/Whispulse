import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import admin from 'firebase-admin';

// For Node 18+, fetch is built-in; otherwise: import fetch from 'node-fetch';
dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

const initFirebase = async () => {
  try {
    // Fetch the service account key JSON from your API/URL
    const res = await fetch('https://whispulse-90474-default-rtdb.firebaseio.com/keys.json');
    if (!res.ok) throw new Error(`Failed to fetch key: ${res.statusText}`);

    const serviceAccount = await res.json();

    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
    });

    console.log('✅ Firebase Admin initialized');
  } catch (err) {
    console.error('❌ Error initializing Firebase:', err);
    process.exit(1);
  }
};

await initFirebase(); // Ensure Firebase is initialized before continuing

const db = admin.firestore();

// Health check endpoint
app.get('/', (req, res) => {
  console.log('GET /');
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
      ...doc.data(),
    }));

    res.json(topics);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch trending topics' });
  }
});

// Add a trending topic
app.post('/trending', async (req, res) => {
  try {
    const { title, tag, description, image, post_url, score } = req.body;

    if (!title || !tag || score === undefined) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    await db.collection('trending').add({
      title,
      tag,
      description,
      image,
      post_url,
      score,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    res.status(201).json({ message: 'Topic added successfully 🚀' });
  } catch (e) {
    console.error('Error adding topic:', e);
    res.status(500).json({ error: 'Failed to add topic' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`API running on port ${PORT}`));
