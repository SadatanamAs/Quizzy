class Question {
  final String uid;
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.uid,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });

  factory Question.fromMap(Map<String, dynamic> data) {
    return Question(
      uid: data['uid'],
      questionText: data['questionText'],
      options: List<String>.from(data['options']),
      correctAnswer: data['correctAnswer'],
    );
  }
}

class Subject {
  const Subject({
    required this.chapterCode,
    required this.subCode,
  });

  final String? subCode;
  final String? chapterCode;
}
