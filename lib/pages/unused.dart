// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:Quizzy/pages/select_subject_page.dart';
// import 'package:Quizzy/question_database.dart';
// import 'package:Quizzy/widgets/category_widget.dart';
// import '../main.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with ActiveSubjects {
//   @override
//   void initState() {
//     subjectInputs();
//     subList4Choice = {
//       for (var entry in chapterMap.entries) subMap[entry.key]!: entry.value
//     };
//     findMatchingKeys();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Get.find<DataController>().currentUser;

//     return Scaffold(
//       appBar: _appBar(user),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               'Choose a category:',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             Expanded(child: CardBuilder(titles: subjects)),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.toNamed('/subjectpage');
//         },
//         tooltip: 'Start Quiz',
//         child: const Icon(Icons.play_arrow),
//       ),
//     );
//   }

//   AppBar _appBar(user) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       title: const Text(
//         'Quizzy',
//         style: TextStyle(
//           color: Colors.deepPurple,
//           fontFamily: 'PlaywriteGBS',
//           fontWeight: FontWeight.bold,
//           fontSize: 22,
//         ),
//       ),
//       actions: [
//         PopupMenuButton<String>(
//           icon: const Icon(Icons.account_circle, color: Colors.deepPurple, size: 30),
//           onSelected: (value) {
//             if (value == 'logout') {
//               Get.find<DataController>().currentUser = null;
//               Get.snackbar(
//                 'Logged Out',
//                 'You have been logged out successfully.',
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.grey[800],
//                 colorText: Colors.white,
//               );
//               Get.offAllNamed('/login');
//             }
//           },
//           itemBuilder: (context) => [
//             PopupMenuItem(
//               value: 'username',
//               enabled: false,
//               child: Text('👤 ${user?.name ?? 'Guest'}'),
//             ),
//             PopupMenuItem(
//               value: 'marks',
//               enabled: false,
//               child: Text('📊 Past Scores: ${user?.quizMarks.join(' | ') ?? '-'}'),
//             ),
//             const PopupMenuDivider(),
//             const PopupMenuItem(
//               value: 'logout',
//               child: Row(
//                 children: [
//                   Icon(Icons.logout, color: Colors.redAccent),
//                   SizedBox(width: 10),
//                   Text('Logout'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
