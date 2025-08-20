import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Quizzy/pages/select_subject_page.dart';
import 'package:Quizzy/question_database.dart';
import 'package:Quizzy/widgets/category_widget.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ActiveSubjects {
  @override
  void initState() {
    subjectInputs();
    subList4Choice = {
      for (var entry in chapterMap.entries) subMap[entry.key]!: entry.value
    };
    findMatchingKeys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Get.find<DataController>().currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting & quick stats card
              _buildHeader(user, theme),
              const SizedBox(height: 18),

              const Padding(
                padding: EdgeInsets.only(left: 2.0, bottom: 8),
                child: Text(
                  'Choose a category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),

              // Subject cards (keeps your existing CardBuilder)
              Expanded(
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CardBuilder(titles: subjects),
                  ),
                ),
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => const SubjectSelectionPage()),
        label: const Text('Start Quiz'),
        icon: const Icon(Icons.play_arrow),
        backgroundColor: const Color.fromARGB(255, 0, 255, 157),
      ),
    );
  }

  Widget _buildHeader(user, ThemeData theme) {
    // Build a compact visual of last marks without changing the user data.
    final List<int> marks = <int>[];
    if (user != null && user.quizMarks.isNotEmpty) {
      // assume quizMarks holds numeric values or strings that can be parsed
      for (var m in user.quizMarks) {
        if (m is int) {
          marks.add(m);
        } else if (m is String) {
          final parsed = int.tryParse(m);
          if (parsed != null) marks.add(parsed);
        }
      }
    }

    return Row(
      children: [
        // Avatar & Greeting card
        Expanded(
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.deepPurple.shade50,
                child: Text(
                  (user != null && user.name.isNotEmpty)
                      ? user.name.trim()[0].toUpperCase()
                      : 'U',
                  style:
                      const TextStyle(fontSize: 22, color: Colors.deepPurple),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user != null ? 'Hello, ${user.name}!' : 'Welcome!',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user != null
                          ? 'Your last quiz marks: ${user.quizMarks.join(' | ')}'
                          : 'Please login to see your marks',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user != null
                          ? 'Ready for a quick practice?'
                          : 'Please login to save your progress',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Quick actions
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Logout icon with confirmation
            IconButton(
              icon: Icon(Icons.logout, color: Colors.deepPurple.shade400),
              tooltip: 'Logout',
              onPressed: () => _confirmLogout(),
            ),
          ],
        ),
      ],
    );
  }

  void _confirmLogout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.find<DataController>().currentUser = null;
              Get.offAllNamed('/');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Colors.white,
    title: const Text(
      'Quizzy',
      style: TextStyle(
        color: Colors.deepPurple,
        // keep your font used earlier; fallback if not available
        fontFamily: 'PlaywriteGBS',
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.sunny, color: Color.fromARGB(255, 0, 0, 0)),
        tooltip: 'Theme',
        onPressed: () {
          Get.snackbar('Info', 'Theme coming soon',
              snackPosition: SnackPosition.BOTTOM);
        },
      ),
      const SizedBox(width: 6),
      IconButton(
        icon: const Icon(Icons.settings, color: Colors.deepPurple),
        tooltip: 'Settings',
        onPressed: () {
          Get.snackbar('Info', 'Settings coming soon',
              snackPosition: SnackPosition.BOTTOM);
        },
      ),
      const SizedBox(width: 6),
    ],
  );
}














//   @override
//   Widget build(BuildContext context) {
//     final user = Get.find<DataController>().currentUser;
//     return Scaffold(
//       appBar: _appBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (user != null) ...[
//               Text('Hello, ${user.name}!',
//                   style: const TextStyle(
//                       fontSize: 22, fontWeight: FontWeight.bold)),
//               Text('Your last quiz marks: ${user.quizMarks.join('| ')}'),
//             ],
//             const Text(
//               'Choose a category:',
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 10),
//             Expanded(child: CardBuilder(titles: subjects)),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.to(() => const SubjectSelectionPage());
//         },
//         tooltip: 'Start Quiz',
//         child: const Icon(Icons.play_arrow),
//       ),
//     );
//   }
// }

// AppBar _appBar() {
//   return AppBar(
//     automaticallyImplyLeading: false,
//     title: const Text(
//       'Quizzy',
//       style: TextStyle(
//         color: Colors.deepPurple,
//         fontFamily: 'PlaywriteGBS',
//         fontWeight: FontWeight.bold,
//         fontSize: 22,
//       ),
//     ),
//     actions: [
//       IconButton(
//         icon: const Icon(Icons.logout, color: Colors.deepPurple),
//         tooltip: 'Logout',
//         onPressed: () {
//           Get.find<DataController>().currentUser = null;
//           Get.offAllNamed('/');
//         },
//       ),
//     ],
//   );
// }




// class CategoryCard extends StatefulWidget {
//   final String category;
//   // final Double cardLength;
//   final IconData icon;

//   const CategoryCard(
//       {super.key,
//       required this.category,
//       // required this.cardLength,
//       required this.icon});

//   @override
//   State<CategoryCard> createState() => _CategoryCardState();
// }

// class _CategoryCardState extends State<CategoryCard> {

//   late List<String> subjects = [];
//   late Map<String, List<String>> subList4Choice;
//   late List<String> allsubjects = subMap.values.toList();

//   void findMatchingKeys() {
//     subjects.clear();
//     for (var item in allsubjects) {
//       if (subList4Choice.containsKey(item)) {
//         subjects.add(item);
//       }
//     }
//     setState(() {}); // Refresh UI
//   }

//   @override
//   void initState() {
//     subList4Choice = {
//       for (var entry in chapterMap.entries) subMap[entry.key]!: entry.value
//     };
//     findMatchingKeys();
//     super.initState();
//   }


//   @override
//   Widget build(BuildContext context) {
//     final double cardLength = subjectInfo.length.toDouble();
//     return Card(
//       elevation: cardLength,
//       child: ListTile(
//         leading: Icon(widget.icon, size: 40),
//         title: Text(widget.category, style: const TextStyle(fontSize: 20)),
//         trailing: const Icon(Icons.arrow_forward),
//         onTap: () {},
//       ),
//     );
//   }
// }


