# 🎮 Quiz Quest | Gamified Learning Experience

[![Flutter Version](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Database](https://img.shields.io/badge/Database-Hive%20NoSQL-orange?logo=hive&logoColor=white)](https://pub.dev/packages/hive)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

**Quiz Quest** is a high-performance, interactive mobile application developed as an **Open Ended Lab (OEL)** at the **National University of Modern Languages (NUML)**. It leverages gamification to transform traditional assessment into a rewarding cognitive journey.

---

## 🎯 Core Philosophy & Wellbeing
Designed with a focus on **SDG-3 (Good Health and Wellbeing)**, the app aims to promote:
* **🧠 Cognitive Agility:** Enhances focus and logical thinking through timed challenges.
* **🏆 Psychological Achievement:** Provides instant gratification via real-time scoring and progress tracking.
* **🌍 Democratized Education:** A lightweight (<17MB), offline-capable tool ensuring learning is accessible to everyone, anywhere.

---

## ✨ Key Features
* **📦 Offline-First Architecture:** Full functionality without internet using **Hive NoSQL**.
* **🔐 Intelligent Auth:** Secure Login/Registration with "Remember Me" session persistence.
* **📚 Dynamic Subjects:** Curated quizzes for **Computer Science**, **Mathematics**, and **General Knowledge**.
* **⚡ Performance Optimized:** ABI Splitting ensures a smooth experience on all devices.
* **📝 Real-time Review:** Post-quiz analysis to review mistakes and learn effectively.
* **📊 User Analytics:** Detailed history logs to track academic growth over time.

---

## 🛠️ Technical Stack & Dependencies

| Package | Version | Purpose |
| :--- | :--- | :--- |
| **Hive** | `^2.2.3` | Lightweight and blazing fast NoSQL database. |
| **Hive Flutter** | `^1.1.0` | Extension for Hive for seamless Flutter integration. |
| **Cupertino Icons** | `^1.0.8` | Premium iconography for a modern aesthetic. |
| **Hive Generator** | `^2.0.1` | *(Dev)* Code generator for Hive TypeAdapters. |
| **Build Runner** | `^2.4.6` | *(Dev)* Automated tool for generating boilerplate code. |

---

## 🚀 Getting Started & Setup Guide

### 1. Prerequisites
Ensure you have the Flutter SDK installed and configured. Verify by running:
```bash
flutter --version

git clone [https://github.com/YourUsername/QuizQuest.git](https://github.com/YourUsername/QuizQuest.git)
cd QuizQuest

lib/
├── main.dart             # Application Entry Point & Hive Initialization
├── splash_screen.dart    # Branding & Auto-Login Logic
├── login_screen.dart     # Authentication & Form Validation
├── home_screen.dart      # Main Navigation Dashboard
├── quiz_screen.dart      # Core Quiz Engine & Scoring Logic
├── quiz_data.dart        # Static Questions & Answers Data
├── services/             # Database Handlers (Hive) & Logic Helpers
├── models/               # Data Models (User, Score, etc.)
└── components/           # Reusable UI Widgets (Custom Buttons, Cards)
