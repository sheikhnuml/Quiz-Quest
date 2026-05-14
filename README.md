# 🚀 Quiz Quest - A Gamified Learning Experience

**Quiz Quest** is a modern, interactive mobile application built with **Flutter**. It is designed to make learning engaging, accessible, and productive. This project was developed as an **Open Ended Lab (OEL)** for the Mobile Application Development (Lab) course at **NUML**.

---

## 🌟 Project Overview
The core philosophy behind **Quiz Quest** is to promote the **wellbeing of individuals and society** by providing a digital environment for cognitive stimulation. Instead of passive screen time, it encourages active learning and memory retention through a competitive and rewarding quiz system.

### 🎯 Goal: Wellbeing of Individual & Society
As per the OEL requirements, this app addresses:
*   **Individual Wellbeing:** Enhances focus, memory, and provides a sense of achievement through scoring.
*   **Social Wellbeing:** democratizes education by providing a free, easy-to-use learning tool for students and lifelong learners.

---

## ✨ Features
*   **Interactive Quiz Interface:** Smooth transitions and real-time feedback during quiz sessions.
*   **Offline Data Persistence:** Powered by **Hive DB**, allowing users to save their login sessions and track progress without needing the internet.
*   **Categorized Learning:** Users can choose from various subjects like Computer Science, Mathematics, and General Knowledge.
*   **Optimized Performance:** The app is built with ABI-splitting technology, ensuring a tiny footprint (<17MB) on modern devices.
*   **Secure Authentication:** A robust Login/Registration system with "Remember Me" functionality.
*   **Modern UI/UX:** Deep Purple & Amber aesthetic theme with high-quality icons and typography.

---

## 🛠️ Tech Stack
*   **Framework:** [Flutter](https://flutter.dev) (v3.10.3 or higher)
*   **Language:** [Dart](https://dart.dev)
*   **Database:** [Hive & Hive Flutter](https://pub.dev/packages/hive) (Lightweight NoSQL)
*   **State Management:** Local State Management (Stateful Widgets)
*   **Icons:** Cupertino Icons & Material Design Icons

---

## 📁 Project Structure
The code is organized for scalability and readability:
```text
lib/
├── main.dart                 # Entry point aur Hive initialization
├── splash_screen.dart        # Branding aur auto-login logic
├── login_screen.dart         # Authentication aur form validation
├── home_screen.dart          # Main dashboard
├── course_menu.dart          # Subjects selection menu
├── quiz_screen.dart          # Core quiz logic aur user interaction
├── quiz_data.dart            # Questions aur answers ka data store
├── review_screen.dart        # Quiz ke baad answers ka review
├── leaderboard_screen.dart   # High scores aur ranking
├── user_profile.dart         # User profile ki settings
├── user_details.dart         # User ki basic information
└── user_history.dart         # Pichli quiz attempts ka record
