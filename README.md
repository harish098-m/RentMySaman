# RentMi

**Your Personal P2P Rental Platform**

RentMi is a peer-to-peer rental marketplace that empowers people to rent out or rent items like cars, bikes, tools, cameras, and more — affordably, safely, and with full control.

## Features

✅ **Demo Authentication** - Quick login for testing
✅ **Smart Search** - Find items by name or location
✅ **Category Filters** - Browse by Car, Bike, Camera, Tool, etc.
✅ **AI Price Suggestions** - Get intelligent pricing recommendations
✅ **Secure Bookings** - Complete booking flow with date selection
✅ **User Verification** - Mobile and Aadhaar verification
✅ **Profile Management** - Track your listings and bookings

## Tech Stack

- **Frontend**: Flutter (Web, Windows)
- **Backend**: Firebase (Auth, Firestore, Storage)
- **AI**: Google Cloud Vision API (for price analysis)
- **Design**: Material Design 3 with custom yellow/black theme

## Getting Started

### Prerequisites
- Flutter SDK (included in `tools/flutter`)
- Chrome browser for web testing

### Run the App

```powershell
cd frontend
..\tools\flutter\bin\flutter run -d chrome
```

### Run Tests

```powershell
cd frontend
..\tools\flutter\bin\flutter test
```

## Quick Demo

1. Click **"Demo Login (Skip Auth)"** to bypass authentication
2. Browse sample listings
3. Click any item to view details
4. Book an item by selecting dates
5. View your profile and bookings

## Project Structure

```
RentMySaman/
├── frontend/
│   ├── lib/
│   │   ├── core/          # Constants, theme, mock data
│   │   ├── models/        # Data models
│   │   ├── screens/       # All app screens
│   │   ├── services/      # Auth, AI services
│   │   ├── widgets/       # Reusable components
│   │   └── main.dart
│   ├── test/              # Unit & widget tests
│   └── pubspec.yaml
├── tools/
│   └── flutter/           # Local Flutter SDK
└── FIREBASE_SETUP.md      # Firebase configuration guide
```

## Firebase Setup

For real authentication, follow the guide in `FIREBASE_SETUP.md` to:
1. Create a Firebase project
2. Enable Phone Authentication
3. Update credentials in `main.dart`

## Contributing

This is a demo project showcasing Flutter development best practices.

## License

MIT License

---

Built with ❤️ using Flutter
