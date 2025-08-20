class User {
  final String name;
  final String userName;
  List<int> quizMarks;
  String _password;

  User({
    required this.name,
    required this.userName,
    required String password,
    this.quizMarks = const [],
  }) : _password = User.encrypter(password);

  String getPassword() {
    return User.decrypter(_password);
  }

  void setPassword(String a) {
    _password = User.encrypter(a);
  }

  static String decrypter(String s) {
    return String.fromCharCodes(s.codeUnits.map((c) => c + 20));
  }

  static String encrypter(String s) {
    return String.fromCharCodes(s.codeUnits.map((c) => c - 20));
  }

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      name: data['name'],
      userName: data['userName'],
      password: data['password'],
      quizMarks: List<int>.from(data['quizMarks'] ?? []),
    );
  }
}
