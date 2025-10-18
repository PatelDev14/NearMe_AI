// backend/firebaseAdmin.js
import admin from 'firebase-admin';
import path from 'path';

const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT_JSON || '{}');

if (!serviceAccount || !serviceAccount.project_id) {
  // fallback for local dev: load JSON file (do NOT commit this file)
  const keyPath = path.resolve('./serviceAccountKey.json');
  admin.initializeApp({
    credential: admin.credential.cert(keyPath),
  });
} else {
  // recommended in production: provide JSON via env var
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });
}

export const db = admin.firestore();
export const authAdmin = admin.auth();
