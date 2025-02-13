# oru_phones

## State Management Approach
This project primarily uses the **Stacked** package for state management. Additionally, **setState** is used in a few places for simpler UI updates.

## Architecture Followed
The project follows a structured directory architecture with clear separation of concerns:

```
lib/
│── model/               # Data models
│── Screens/             # UI screens
│── services/            # API and service handling
│── firebase_options.dart # Firebase configuration
│── main.dart            # Entry point
```

## Steps to Set Up and Run the Project

### Prerequisites
- Install Flutter ([Guide](https://flutter.dev/docs/get-started/install))
- Ensure you have Dart installed
- Set up an Android/iOS emulator or a physical device

### Installation
1. **Clone the Repository:**
   ```sh
   git clone https://github.com/MMWARRIOR03/oru_phones.git
   cd <project-folder>
   ```
2. **Install Dependencies:**
   ```sh
   flutter pub get
   ```
3. **Set Up Firebase (If Required):**
   - Ensure you have the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) in place.

4. **Run the App:**
   ```sh
   flutter run
   ```

### Additional Commands
- **Analyze Code:**
  ```sh
  flutter analyze
  ```
- **Run Tests:**
  ```sh
  flutter test
  ```
- **Build APK:**
  ```sh
  flutter build apk
  ```

## Features Implemented
- Splash Screen
- Authentication (OTP-based Login)
- Home Screen with Paginated Listings
- Product Filtering and Liking
- Firebase Push Notifications (if configured)

## Contribution
Feel free to fork and contribute by submitting pull requests.

---
Maintained by [Your Name/Team]

