import 'package:Quizzy/models/question_model.dart';

Map<String, String> subjectInfo = {
  for (var entry in subMap.entries) entry.value: entry.key
};

Map<String, List<String>> chapterMap = {};

void subjectInputs() {
  String subCode;
  String chapCode;
  for (var question in questiondata) {
    subCode = question.uid.substring(0, 3);
    chapCode = question.uid.substring(3, 5);
    var subject = subMap[subCode] ?? 'Unknown Subject';
    if (subject == 'Unknown Subject') {
      continue;
    }
    if (!chapterMap.containsKey(subCode)) {
      chapterMap[subCode] = [];
    }
    if (!chapterMap[subCode]!.contains(chapCode)) {
      chapterMap[subCode]!.add(chapCode);
      chapterMap[subCode]!.sort();
//       print(subMap);
    }
  }
}

// ** I need to update MANUALLY **
Map<String, String> subMap = {
  '171': 'Physics 1st',
  '172': 'Physics 2nd',
  '271': 'Chemistry 1st',
  '272': 'Chemistry 2nd',
  '261': 'Mathematics 1st',
  '262': 'Mathematics 2nd',
  '280': 'Biology 1st',
  '281': 'Biology 2nd'
};

// ** I need to update MANUALLY **
List<Question> questiondata = [
  Question(
      questionText: "question1",
      uid: "17101001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option1"),
  Question(
      questionText: "question2",
      uid: "17102002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option2"),
  Question(
      questionText: "question3",
      uid: "17201001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option3"),
  Question(
      questionText: "question4",
      uid: "17202002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option4"),
  Question(
      questionText: "question5",
      uid: "17203003",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option1"),
  Question(
      questionText: "question6",
      uid: "17201001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option2"),
  Question(
      questionText: "question7",
      uid: "17202002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option3"),
  Question(
      questionText: "question8",
      uid: "17201001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option4"),
  Question(
      questionText: "question9",
      uid: "17202002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option1"),
  Question(
      questionText: "question10",
      uid: "17203003",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option2"),
  Question(
      questionText: "question11",
      uid: "27101001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option3"),
  Question(
      questionText: "question12",
      uid: "27102002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option4"),
  Question(
      questionText: "question13",
      uid: "27201001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option1"),
  Question(
      questionText: "question14",
      uid: "27202002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option2"),
  Question(
      questionText: "question15",
      uid: "27203003",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option3"),
  Question(
      questionText: "question16",
      uid: "27201001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option4"),
  Question(
      questionText: "question17",
      uid: "27202002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option1"),
  Question(
      questionText: "question18",
      uid: "27203003",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option2"),
  Question(
      questionText: "question19",
      uid: "27201001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option3"),
  Question(
      questionText: "question20",
      uid: "27202002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option4"),
  Question(
      questionText: "question27",
      uid: "26102002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option1"),
  Question(
      questionText: "question28",
      uid: "26101001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option2"),
  Question(
      questionText: "question29",
      uid: "26102002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option3"),
  Question(
      questionText: "question30",
      uid: "26203003",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option4"),
  Question(
      questionText: "question21",
      uid: "26201001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option1"),
  Question(
      questionText: "question22",
      uid: "26202002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option2"),
  Question(
      questionText: "question23",
      uid: "26201001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option3"),
  Question(
      questionText: "question24",
      uid: "26202002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option4"),
  Question(
      questionText: "question25",
      uid: "26203003",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option1"),
  Question(
      questionText: "question26",
      uid: "26201001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option2"),
  Question(
      questionText: "question1",
      uid: "28001001",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option1"),
  Question(
      questionText: "question2",
      uid: "28102002",
      options: ["option1", "option2", "option3", "option4"],
      correctAnswer: "option2"),
];
