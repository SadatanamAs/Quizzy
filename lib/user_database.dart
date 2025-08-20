import 'models/user_model.dart';

class UserDatabase {
  static final UserDatabase _instance = UserDatabase._internal();
  factory UserDatabase() {
    return _instance;
  }
  UserDatabase._internal();

  final List<User> _users = [];

  Future<User?> getUser(String userName) async {
    try {
      return _users.firstWhere((u) => u.userName == userName);
    } catch (_) {
      return null;
    }
  }

  Future<bool> addUser(User user) async {
    if (await getUser(user.userName) != null) return false;
    _users.add(user);
    return true;
  }

  Future<bool> validateUser(String userName, String password) async {
    final user = await getUser(userName);
    if (user == null) return false;
    return user.getPassword() == User.encrypter(password);
  }

  void updateUser(User user) {
    final idx = _users.indexWhere((u) => u.userName == user.userName);
    if (idx != -1) _users[idx] = user;
  }

  List<User> get allUsers => List.unmodifiable(_users);
}
