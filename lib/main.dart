import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Quizzy/models/question_model.dart';
import 'package:Quizzy/pages/home_page.dart';
import 'package:Quizzy/pages/ques_page.dart';
import 'package:Quizzy/pages/result_page.dart';
import 'package:Quizzy/pages/login_page.dart';
import 'package:Quizzy/pages/select_subject_page.dart';
import 'models/user_model.dart';
import 'user_database.dart';

void main() {
  Get.put(DataController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.quicksandTextTheme()),
      routes: {
        '/': (context) => const LoginPage(), // Add this line
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/quizpage': (context) => const QuestionPage(),
        '/subjectpage': (context) => const SubjectSelectionPage(),
        '/resultpage': (context) => const ResultPage(),
      },
      initialRoute: '/login',
    );
  }
}

class DataController extends GetxController {
  Map<String, int> resultData = {};
  List<Subject> subjectData = [];
  User? currentUser;

  void setData(Map<String, int> value) {
    resultData = value;
    if (currentUser != null && value.containsKey('correctAns')) {
      currentUser!.quizMarks = [
        ...currentUser!.quizMarks,
        value['correctAns']!
      ];
      UserDatabase().updateUser(currentUser!);
    }
  }

  void setSubject(List<Subject> value) {
    subjectData = value;
  }
}
