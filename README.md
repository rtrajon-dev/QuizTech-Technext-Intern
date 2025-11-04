# Quiz Tech

A Flutter-based Quiz application that allows users to take quizzes, track scores, and view their progress. It uses Hive for local storage and Provider for state management.

---

## Table of Contents

- [Features](#features)  
- [Project Structure](#project-structure)  
- [Installation](#installation)  
- [First-Time Setup](#first-time-setup)  
- [Step-by-Step Quiz Usage Guide](#step-by-step-quiz-usage-guide)  
- [Running the App](#running-the-app)  
- [Screenshots](#screenshots)  
- [Dependencies](#dependencies)  
- [License](#license)  

---

## Features

- User authentication (login)  
- Onboarding screen for first-time users  
- Quiz functionality with score tracking  
- Local storage of quiz progress using Hive  
- Score summary with total score and history  
- Responsive UI with Flutter ScreenUtil  
- Navigation between screens (Home, Quiz, Details, Score)  

---

## Project Structure

```

lib/
├── constants/
│   └── app_colors.dart
├── layout/
│   └── main_layout.dart
├── provider/
│   └── auth_provider.dart
├── screens/
│   ├── onboarding_screen.dart
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── dashboard_screen.dart
│   ├── quiz_screen.dart
│   ├── details_screen.dart
│   └── score_screen.dart
└── main.dart

assets/
└── (images, icons, etc.)

fonts/
├── Ubuntu-Bold.ttf
└── Ubuntu-Regular.ttf

````

---

## Installation

1. **Clone the repository**

```bash
git clone <repository_url>
cd loginsignup
````

2. **Install Flutter dependencies**

```bash
flutter pub get
```

3. **Ensure Flutter SDK is installed**

Check Flutter version:

```bash
flutter --version
```

4. **Initialize Hive**

Hive is used for local data storage. Hive boxes are opened automatically in `main.dart`. No additional setup is needed.

---

## First-Time Setup

1. **Onboarding**:
   When running the app for the first time, users are guided through the onboarding screens to learn about app features.

2. **Login**:
   Use the login screen to enter credentials. If no user exists yet, register a new user or simulate a login by updating `AuthProvider`.

3. **Navigation**:
   After login, users will be redirected to the main layout (`MainLayout`) which contains Home, Dashboard, Profile, and Quiz sections.

4. **Hive Storage**:
   Quiz scores are saved locally under the `quiz_progress` Hive box. There is no backend required, so all progress persists on the device.

---

## Step-by-Step Quiz Usage Guide

1. **Start a Quiz**

    * Go to the Home screen.
    * Select a quiz from the list of available quizzes.
    * Tap on the quiz to open `QuizScreen`.

2. **Answer Questions**

    * Each question appears with multiple-choice options.
    * Tap on the correct answer for each question.
    * The app will automatically store your selected answers locally.

3. **Submit Quiz**

    * After answering all questions, submit the quiz.
    * The score for the quiz is calculated and saved in the `quiz_progress` Hive box.

4. **View Scores**

    * Navigate to the Score screen (`ScoreScreen`) from the main layout.
    * You can see the total score and the history of all quizzes.
    * Only the latest attempt for each quiz is considered in the total score.

5. **Share Your Score** *(Coming Soon)*

    * A share button is available to share your achievements.

6. **Return to Home**

    * Use the “Go to Home” button to return to the Home screen and attempt other quizzes.

---

## Running the App

Run the app on an emulator or physical device:

```bash
flutter run
```

For release build (Android):

```bash
flutter build apk --release
```

For iOS:

```bash
flutter build ios --release
```

---

## Screenshots

**Onboarding Screen**
![Onboarding](assets/screenshots/onboarding.png)

**Login Screen**
![Login](assets/screenshots/login.png)

**Home Screen**
![Home](assets/screenshots/home.png)

**Quiz Screen**
![Quiz](assets/screenshots/quiz.png)

**Score Screen**
![Score](assets/screenshots/score.png)

---

## Dependencies

* `provider` – State management
* `hive_flutter` – Local storage
* `flutter_screenutil` – Responsive UI
* `shared_preferences` – Persistent storage
* `flutter_secure_storage` – Secure token storage
* `http` – Networking
* `jwt_decoder` – Decode JWT tokens
* `fluttertoast` – Display toast messages
* `form_field_validator` – Form validation

---

## License

This project is open-source and free to use for learning and personal projects.
