// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../user_database.dart';
// import '../models/user_model.dart';
// import '../main.dart';
// import 'home_page.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   String userName = '';
//   String password = '';
//   String name = '';
//   bool isLogin = true;
//   String error = '';

//   Future<void> login() async {
//     if (await UserDatabase().validateUser(userName, password)) {
//       Get.find<DataController>().currentUser =
//           await UserDatabase().getUser(userName);

//       Get.snackbar(
//         'Login Successful',
//         'Welcome back, $userName!',
//         backgroundColor: Colors.green[400],
//         snackPosition: SnackPosition.TOP,
//         colorText: Colors.white,
//         duration: const Duration(seconds: 1),
//       );

//       await Future.delayed(const Duration(milliseconds: 800));
//       Get.offAll(() => const HomePage());
//     } else {
//       setState(() => error = 'Invalid credentials');
//     }
//   }

//   Future<void> register() async {
//     final encryptedPass = User.encrypter(password);
//     final user = User(name: name, userName: userName, password: encryptedPass);
//     if (await UserDatabase().addUser(user)) {
//       Get.snackbar(
//         'Registration Success',
//         'Please login!',
//         backgroundColor: Colors.green[400],
//         snackPosition: SnackPosition.TOP,
//         colorText: Colors.white,
//         duration: const Duration(seconds: 1),
//       );

//       await Future.delayed(const Duration(milliseconds: 800));
//       setState(() {
//         isLogin = true;
//         error = '';
//       });
//     } else {
//       setState(() => error = 'User already exists');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isLogin ? 'Login' : 'Register'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Card(
//             elevation: 8,
//             margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             child: Padding(
//               padding: const EdgeInsets.all(24),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.account_circle,
//                         size: 64, color: Colors.blueGrey.shade300),
//                     const SizedBox(height: 16),
//                     if (!isLogin)
//                       TextFormField(
//                         decoration: const InputDecoration(
//                             labelText: 'Name', prefixIcon: Icon(Icons.person)),
//                         onChanged: (v) => name = v,
//                         validator: (v) => v!.isEmpty ? 'Enter name' : null,
//                       ),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                           labelText: 'Username',
//                           prefixIcon: Icon(Icons.person_outline)),
//                       onChanged: (v) => userName = v,
//                       validator: (v) => v!.isEmpty ? 'Enter username' : null,
//                     ),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                           labelText: 'Password', prefixIcon: Icon(Icons.lock)),
//                       obscureText: true,
//                       onChanged: (v) => password = v,
//                       validator: (v) => v!.isEmpty ? 'Enter password' : null,
//                     ),
//                     const SizedBox(height: 16),
//                     if (error.isNotEmpty)
//                       Text(error, style: const TextStyle(color: Colors.red)),
//                     const SizedBox(height: 8),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           isLogin ? login() : register();
//                         }
//                       },
//                       child: Text(isLogin ? 'Login' : 'Register',
//                           style: const TextStyle(fontSize: 18)),
//                     ),
//                     TextButton(
//                       onPressed: () => setState(() => isLogin = !isLogin),
//                       child: Text(isLogin
//                           ? 'Create Account'
//                           : 'Have an account? Login'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../user_database.dart';
import '../models/user_model.dart';
import '../main.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String password = '';
  String name = '';
  bool isLogin = true;
  String error = '';

  bool showPassword = false;
  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      error = '';
      isLoading = true;
    });

    if (await UserDatabase().validateUser(userName, password)) {
      Get.find<DataController>().currentUser =
          await UserDatabase().getUser(userName);

      Get.snackbar(
        'Login Successful',
        'Welcome back, $userName!',
        backgroundColor: Colors.green[400],
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );

      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;
      setState(() => isLoading = false);
      Get.offAll(() => const HomePage());
    } else {
      if (!mounted) return;
      setState(() {
        error = 'Invalid credentials';
        isLoading = false;
      });
    }
  }

  Future<void> register() async {
    setState(() {
      error = '';
      isLoading = true;
    });

    final encryptedPass = User.encrypter(password);
    final user = User(name: name, userName: userName, password: encryptedPass);
    if (await UserDatabase().addUser(user)) {
      Get.snackbar(
        'Registration Success',
        'Please login!',
        backgroundColor: Colors.green[400],
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );

      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;
      setState(() {
        isLogin = true;
        error = '';
        isLoading = false;
      });
    } else {
      if (!mounted) return;
      setState(() {
        error = 'User already exists';
        isLoading = false;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (isLogin) {
        login();
      } else {
        register();
      }
    }
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData prefix,
    Widget? suffix,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  void _showComingSoon() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Coming soon'),
        content:
            const Text('This feature will be available in a future update.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE8F0FF), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Card(
                  elevation: 18,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.school,
                                  color: Colors.blue, size: 32),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isLogin ? 'Welcome Back' : 'Create Account',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    isLogin
                                        ? 'Sign in to continue to Quizzy'
                                        : 'Enter details to create a new account',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => isLogin = !isLogin),
                              child: Chip(
                                label: Text(isLogin ? 'Register' : 'Login'),
                                backgroundColor: Colors.grey.shade100,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Form(
                          key: _formKey,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                              key: ValueKey<bool>(isLogin),
                              children: [
                                if (!isLogin)
                                  TextFormField(
                                    decoration: _inputDecoration(
                                      label: 'Full name',
                                      prefix: Icons.person,
                                      hint: 'Your display name',
                                    ),
                                    onChanged: (v) => name = v,
                                    validator: (v) =>
                                        v == null || v.trim().isEmpty
                                            ? 'Enter name'
                                            : null,
                                  ),
                                if (!isLogin) const SizedBox(height: 12),
                                TextFormField(
                                  decoration: _inputDecoration(
                                    label: 'Username',
                                    prefix: Icons.person_outline,
                                    hint: 'e.g. rifat123',
                                  ),
                                  onChanged: (v) => userName = v,
                                  validator: (v) =>
                                      v == null || v.trim().isEmpty
                                          ? 'Enter username'
                                          : null,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  decoration: _inputDecoration(
                                    label: 'Password',
                                    prefix: Icons.lock,
                                    suffix: IconButton(
                                      onPressed: () => setState(
                                          () => showPassword = !showPassword),
                                      icon: Icon(showPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                    hint: 'At least 6 characters',
                                  ),
                                  obscureText: !showPassword,
                                  onChanged: (v) => password = v,
                                  validator: (v) => v == null || v.isEmpty
                                      ? 'Enter password'
                                      : null,
                                ),
                                const SizedBox(height: 12),
                                if (error.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.error_outline,
                                            color: Colors.redAccent, size: 18),
                                        const SizedBox(width: 8),
                                        Expanded(
                                            child: Text(error,
                                                style: const TextStyle(
                                                    color: Colors.redAccent))),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 6),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 6,
                                    ),
                                    onPressed: isLoading ? null : _submit,
                                    child: isLoading
                                        ? const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Colors.white)),
                                              SizedBox(width: 12),
                                              Text('Please wait...'),
                                            ],
                                          )
                                        : Text(isLogin ? 'Login' : 'Register',
                                            style:
                                                const TextStyle(fontSize: 16)),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: _showComingSoon,
                                      child: const Text('Forgot password?'),
                                    ),
                                    TextButton(
                                      onPressed: () => setState(() {
                                        isLogin = !isLogin;
                                        error = '';
                                      }),
                                      child: Text(isLogin
                                          ? 'Create Account'
                                          : 'Have an account? Login'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
