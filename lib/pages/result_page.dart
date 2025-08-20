import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Quizzy/main.dart';
import 'package:Quizzy/pages/home_page.dart';
import 'package:Quizzy/user_database.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, r});
  @override
  Widget build(BuildContext context) {
    final result = Get.find<DataController>().resultData;
    final user = Get.find<DataController>().currentUser;
    double marks;
    if (result['incorrectAns'] != 0) {
      marks = result['correctAns']! - (result['incorrectAns']! * 0.25);
    } else {
      marks = result['correctAns']!.toDouble();
    }

    if (user != null &&
        (user.quizMarks.isEmpty || user.quizMarks.last != marks.round())) {
      user.quizMarks = [...user.quizMarks, marks.round()];
      UserDatabase().updateUser(user);
    }

    final totalQuestions = result['totalQuestion'] ?? 1;
    // progress for circular indicator (clamped between 0 and 1)
    final double progress =
        (marks / (totalQuestions.toDouble())).clamp(0, 1).toDouble();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Results'),
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
          child: Column(
            children: [
              // Top card with circular score
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 22.0),
                  child: Row(
                    children: [
                      // Circular score indicator
                      SizedBox(
                        width: 110,
                        height: 110,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 110,
                              height: 110,
                              child: CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 10,
                                backgroundColor: Colors.grey.shade200,
                                color: Colors.deepPurple,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  marks.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${(progress * 100).round()}%',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 18),

                      // Summary text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Quiz Completed!',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text(
                              user != null
                                  ? 'Well done, ${user.name}.'
                                  : 'Well done.',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _StatTile(
                                    label: 'Total', value: '$totalQuestions'),
                                const SizedBox(width: 8),
                                _StatTile(
                                    label: 'Correct',
                                    value: '${result['correctAns']}'),
                                const SizedBox(width: 8),
                                _StatTile(
                                    label: 'Incorrect',
                                    value: '${result['incorrectAns']}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // Detailed card with breakdown
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 18.0),
                  child: Column(
                    children: [
                      _InfoRow(
                          label: 'Total Questions',
                          value: '${result['totalQuestion']}'),
                      const Divider(),
                      _InfoRow(
                          label: 'Correct Answers',
                          value: '${result['correctAns']}'),
                      const Divider(),
                      _InfoRow(
                          label: 'Incorrect Answers',
                          value: '${result['incorrectAns']}'),
                      const Divider(),
                      _InfoRow(
                          label: 'Skipped', value: '${result['skippedAns']}'),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Final Score',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Text(marks.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Get.to(() => const HomePage());
                  },
                  child: const Text('Back to Home',
                      style:  TextStyle(fontSize: 16,color: Color.fromRGBO(96, 19, 250, 0.932)),
                      )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
              child:
                  Text(label, style: TextStyle(color: Colors.grey.shade700))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// class ResultPage extends StatelessWidget {
//   const ResultPage({super.key, r});
//   @override
//   Widget build(BuildContext context) {
//     final result = Get.find<DataController>().resultData;
//     final user = Get.find<DataController>().currentUser;
//     double marks;
//     if (result['incorrectAns'] != 0) {
//       marks = result['correctAns']! - (result['incorrectAns']! * 0.25);
//     } else {
//       marks = result['correctAns']!.toDouble();
//     }

//     if (user != null && (user.quizMarks.isEmpty || user.quizMarks.last != marks.round())) {
//       user.quizMarks = [...user.quizMarks, marks.round()];
//       UserDatabase().updateUser(user);
//     }

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Results'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               const Text(
//                 'Quiz Completed!',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Total Questions: ${result['totalQuestion']}',
//                 style: const TextStyle(fontSize: 18),
//               ),
//               Text(
//                 'Correct Answers: ${result['correctAns']}',
//                 style: const TextStyle(fontSize: 18),
//               ),
//               Text(
//                 'Incorrect Answers: ${result['incorrectAns']}',
//                 style: const TextStyle(fontSize: 18),
//               ),
//               Text(
//                 'Skip: ${result['skippedAns']}',
//                 style: const TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Score: $marks',
//                 style:
//                     const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.to(() => const HomePage());
//                 },
//                 child: const Text('Home'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
