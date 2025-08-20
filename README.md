# QUIZZY

A professional, dynamic, and customizable quiz platform built with **Flutter** and **GetX**.

---

## Overview

**Quizzy** showcases modern Flutter development practices with a focus on clarity, reliability, and maintainability. The codebase uses modular organization and reactive state handling so the app scales cleanly as features or content grow. A core strength is the app’s **auto-updating subject/chapter system** — content-driven so the UI reflects the question data without manual configuration.


## Author's Note
Dear viewers, 
I am ***Sadat Anam***, an Undergraduate Cse student. I started this project while I was still learning Flutter and Dart. Initially, I used this as a practice project to implement my learnings into handon skill. As I progressed, I brought new things, new logics and Ideas into the app. 
Here is some clearifications I would like to make:
- My indepth knowleadge was not great since I used only online free resources.
- I alone built the logics however I used Copilot for debuggings in rare cases where documentations are hard to understand.
- For better UI, I took help grom ChatGPT. {All my original codes are commented under the chatGPT improvised UI code}
- This app *does not have any Database*. So storing user Information parmanrntly ism not possible. After every Hot Refresh, user data resets to null.
- I didnot intend to make this app at professional level initially

Thank you, 
I hope you enjoy the experience...

---

## Features

Below each feature is written plainly and expanded to explain the process and user flow — suitable for documentation, interviews, or a project README.

* **User Authentication**

  * Secure registration and login with encrypted passwords.
  * **Process:** A user signs up with name and email, the password is hashed, *encrypted* and stored, and a session token is created on successful login. The home page displays the user’s name and a concise quiz history summary. Error states (invalid credentials, network issues) are handled with clear messages. After every Hot Refresh, user data resets to null sice this app doesnt have any database connection.

* **Dynamic Subject & Chapter Management**

  * Subjects and chapters are automatically updated based on the questions present in the database.
  * **Process:** On app start (or when the question database is refreshed), the app scans question records for their `subject` and `chapter` fields, de-duplicates them, and builds the subject→chapter hierarchy shown in the UI. *Adding new Questions to the Database(for now manual database) will automatically update the chapterlist and SubjectList with just 10Digit UID*.
  

* **Quiz Engine**

  * Select chapters and generate custom quizzes.
  * Multiple-choice questions with no correction on 2nd selection.
  * Tracks correct, incorrect, and skipped answers.
  * Negative marking for incorrect answers.
  * **Process:** The user chooses a subject and chapter(s), optionally sets quiz length and negative marking rules, and starts the quiz. Questions are drawn from the indexed pool (optionally randomized). During the quiz, each answer is evaluated immediately and recorded in the session state. At submission (or when the quiz ends), the engine calculates total score, applies negative marks.

* **User Progress Tracking**

  * Each user's quiz marks are stored and displayed.
  * Visualize your progress and improvement over time.
  * **Process:** After each quiz, the result is appended to the user’s history. The home page reads this history to display recent scores and simple trend indicators (for example: last 5 attempts average). This enables quick review of strengths and weaknesses by chapter.

* **Modern UI/UX**

  * Responsive design for web and mobile.
  * Clean, professional interface with Google Fonts.
  * Animated transitions and snackbars for notifications.
  * **Process:** The layout adapts from narrow (mobile) to wide (tablet/web). Key interactions—starting a quiz, submitting an answer, and viewing results—use concise animations and contextual snackbars so users receive immediate, gentle feedback without interrupting flow.

* **Efficient State Management**

  * Powered by GetX for scalable and maintainable state handling.
  * Centralized data controller for user/session/quiz state.
  * **Process:** Controllers (AuthController, QuizController, IndexController) expose reactive state streams watched by UI widgets. When the question index updates or the user's session changes, bound widgets update automatically without manual refreshes. This keeps UI code minimal and predictable.

---

## Uniqueness & Technical Highlights

* **Auto-Update Chapters/Subjects:**
  The app parses the question database and automatically updates available subjects and chapters. Add questions, and the UI updates immediately — no hardcoded lists or manual wiring required.
  
  ```
  SubjectCode:
    '280': 'Biology 1st',
    '281': 'Biology 2nd'

  Database:{
    Question(
      questionText: "question1",
      uid: "28001001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option1"),
    ~~Question(~~
      ~~questionText: "question2",~~
      ~~uid: "28102002",~~
      ~~options: ["option1", "option2", "option3", "option4"],~~
      ~~correctAnswer: "option2")~~
  }
  ```
  ***PICTURE***

* **Modular Architecture:**
  Each feature (authentication, quiz, results, subject selection) is implemented in its own module/page to simplify maintenance and testing.

* **Encrypted Passwords:**
  User passwords are stored in encrypted/hashed form to demonstrate secure handling of credentials.


---

## Project Structure

```
lib/
├── main.dart
├── models/
│   ├── user_model.dart
│   └── question_model.dart
├── pages/
│   ├── login_page.dart
│   ├── home_page.dart
│   ├── select_subject_page.dart
│   ├── ques_page.dart
│   └── result_page.dart
├── question_database.dart
├── user_database.dart
└── widgets/
    └── category_widget.dart
```

---

## Future Improvements

* **Persistent Storage:** Integrate Hive, SQLite, or Firebase for permanent user and quiz data storage.
* **Admin Panel:** Allow admins to add/edit/delete questions and manage subjects/chapters via UI.
* **Analytics Dashboard:** Visualize user progress, popular subjects, and quiz statistics.
* **Timed Quizzes & Leaderboards:** Add time limits and global leaderboards for competitive play.
* **Question Types:** Support for more question types (true/false, fill-in-the-blank, etc.).
* **Theming & Accessibility:** Add dark mode, font size adjustment, and accessibility features.

---

## Why This Project Stands Out

* **No Hardcoded Subjects/Chapters:**
  The app’s ability to auto-update subjects and chapters from the question database is a practical, time-saving feature that simplifies content updates.

* **Clean, Modern Codebase:**
  Using GetX and modular design makes the project easy to understand, extend, and maintain.

* **Security & UX:**
  Even as a demo, the app follows good security practices and presents a polished user experience.

---

## Author

Developed by \[Sadat Anam].

---

