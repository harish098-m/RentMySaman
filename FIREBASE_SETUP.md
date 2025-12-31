# Firebase Setup Guide for RentMi

## Prerequisites
- Google account
- Access to Firebase Console

## Step-by-Step Setup

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: `RentMi`
4. Disable Google Analytics (optional for now)
5. Click "Create project"

### 2. Enable Phone Authentication

1. In Firebase Console, go to **Authentication** → **Sign-in method**
2. Click on **Phone** provider
3. Click **Enable**
4. Click **Save**

### 3. Register Web App

1. In Firebase Console, click the **Web icon** (`</>`) to add a web app
2. Enter app nickname: `RentMi Web`
3. **Check** "Also set up Firebase Hosting" (optional)
4. Click **Register app**
5. **Copy the Firebase configuration** - you'll see something like:

```javascript
const firebaseConfig = {
  apiKey: "AIza...",
  authDomain: "rentmysaman.firebaseapp.com",
  projectId: "rentmysaman",
  storageBucket: "rentmysaman.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abc123"
};
```

### 4. Update main.dart

Replace the demo credentials in `lib/main.dart` with your real Firebase config:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    appId: 'YOUR_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    authDomain: 'YOUR_AUTH_DOMAIN',
    storageBucket: 'YOUR_STORAGE_BUCKET',
  ),
);
```

### 5. Configure reCAPTCHA for Web

For web phone authentication, you need to add your domain to the authorized domains:

1. In Firebase Console, go to **Authentication** → **Settings** → **Authorized domains**
2. Add `localhost` for local testing
3. The reCAPTCHA will appear automatically during phone verification

### 6. Test Phone Authentication

1. Run the app: `..\tools\flutter\bin\flutter run -d chrome`
2. Enter a real phone number (your own for testing)
3. Click "Send OTP"
4. Complete the reCAPTCHA verification
5. Enter the OTP you receive via SMS
6. You should be logged in!

## For Production Deployment

### Enable Firestore Database

1. In Firebase Console, go to **Firestore Database**
2. Click **Create database**
3. Start in **test mode** (for development)
4. Choose a location (e.g., `asia-south1` for India)
5. Click **Enable**

### Set up Firebase Storage

1. In Firebase Console, go to **Storage**
2. Click **Get started**
3. Start in **test mode**
4. Click **Done**

## Troubleshooting

### "reCAPTCHA verification failed"
- Make sure your domain is in authorized domains
- Clear browser cache and try again

### "Invalid phone number"
- Phone number must be in E.164 format: `+919876543210`
- The app automatically adds `+91` for Indian numbers

### "Too many requests"
- Firebase has rate limits for phone auth
- Wait a few minutes and try again

## Current Status

✅ Demo mode working (bypass authentication)
⏳ Real Firebase setup required for phone auth
📱 Once configured, phone OTP will work in real-time

## Next Steps After Firebase Setup

1. Update `main.dart` with real credentials
2. Test phone authentication
3. Set up Firestore for storing listings
4. Set up Storage for image uploads
5. Deploy to Firebase Hosting
