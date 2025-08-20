import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Quizzy/constants.dart';
import 'package:Quizzy/main.dart';
import 'package:Quizzy/models/question_model.dart';
import 'package:Quizzy/pages/home_page.dart';
import 'package:Quizzy/pages/result_page.dart';
import 'package:Quizzy/question_database.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  filterQues(List<Question> questions, List<Subject> subListz) {
    List<String> choice = subListz.map((subject) {
      // print('${subject.subCode}${subject.chapterCode}');
      return '${subject.subCode}${subject.chapterCode}';
    }).toList();
    final List<Question> finalQuestions;
    if (choice.contains('')) {
      finalQuestions = questions;
    } else {
      finalQuestions = questions.where((question) {
        return choice.contains(question.uid.substring(0, choice[0].length));
      }).toList();
    }
    return finalQuestions;
  }

  final subList = Get.find<DataController>().subjectData;
  // print(subList);
  late List<int?> selectedOptions;
  double finalMark = 0;
  int correct = 0;
  int incorrect = 0;
  late int skipped;

  List<Question> get questions {
    final subList = Get.find<DataController>().subjectData;
    return filterQues(questiondata, subList);
  }

  @override
  void initState() {
    selectedOptions = List.filled(questions.length, null);
    skipped = questions.length;
    super.initState();
  }

  int get answeredCount =>
      selectedOptions.where((element) => element != null).length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Quiz'),
        leading: IconButton(
          icon: backIcon,
          onPressed: () {
            Get.dialog(
              AlertDialog(
                title: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Do you want to Quit?"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const HomePage());
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          },
        ),
        elevation: 1,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: Colors.black87,
      ),

      // Live progress header (UI-only)
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Questions: ${questions.length}',
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Answered: $answeredCount • Skipped: $skipped',
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // simple progress indicator
                          SizedBox(
                            width: 120,
                            child: LinearProgressIndicator(
                              value: questions.isEmpty
                                  ? 0
                                  : answeredCount / questions.length,
                              minHeight: 8,
                              backgroundColor: Colors.grey.shade200,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Questions list
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final q = questions[index];
                final isAnswered = selectedOptions[index] != null;

                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // question header with index
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: isAnswered
                                  ? Colors.deepPurple.shade100
                                  : Colors.grey.shade200,
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: isAnswered
                                      ? Colors.deepPurple
                                      : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                q.questionText,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // options
                        Column(
                          children: q.options.asMap().entries.map((entry) {
                            int idx = entry.key;
                            String option = entry.value;
                            final optionValue = idx + 1;
                            final selected =
                                selectedOptions[index] == optionValue;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: selected
                                      ? const Color.fromARGB(162, 94, 53, 177)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: selected
                                        ? Colors.deepPurple.shade100
                                        : Colors.grey.shade200,
                                  ),
                                ),
                                child: RadioListTile<int>(
                                  title: Text(option,
                                      style: TextStyle(
                                          color: selected
                                              ? Colors.black87
                                              : Colors.black87)),
                                  value: optionValue,
                                  activeColor: Colors.deepPurple,
                                  groupValue:
                                      selectedOptions[index], // logic unchanged
                                  onChanged: (value) {
                                    if (selectedOptions[index] != value) {
                                      setState(() {
                                        if (selectedOptions[index] == null) {
                                          selectedOptions[index] = value!;
                                          skipped--;
                                          if (questions[index]
                                                  .options[value - 1] ==
                                              questions[index].correctAnswer) {
                                            finalMark++;
                                            correct++;
                                          } else {
                                            finalMark -= 0.25;
                                            incorrect++;
                                          }
                                        }
                                      });
                                    }
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // bottom submit bar kept functionally identical but visually improved
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Do you want to Submit?"),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.find<DataController>().setData({
                                'totalQuestion': questions.length,
                                'correctAns': correct,
                                'incorrectAns': incorrect,
                                'skippedAns': skipped,
                              });
                              Get.to(() => const ResultPage());
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16,color: Color.fromRGBO(96, 19, 250, 0.932)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class QuestionPage extends StatefulWidget {
//   const QuestionPage({super.key});

//   @override
//   State<QuestionPage> createState() => _QuestionPageState();
// }

// class _QuestionPageState extends State<QuestionPage> {
//   filterQues(List<Question> questions, List<Subject> subListz) {
//     List<String> choice = subListz.map((subject) {
//       // print('${subject.subCode}${subject.chapterCode}');
//       return '${subject.subCode}${subject.chapterCode}';
//     }).toList();
//     final List<Question> finalQuestions;
//     if (choice.contains('')) {
//       finalQuestions = questions;
//     } else {
//       finalQuestions = questions.where((question) {
//         return choice.contains(question.uid.substring(0, choice[0].length));
//       }).toList();
//     }
//     return finalQuestions;
//   }

//   final subList = Get.find<DataController>().subjectData;
//   // print(subList);
//   late List<int?> selectedOptions;
//   double finalMark = 0;
//   int correct = 0;
//   int incorrect = 0;
//   late int skipped;

//   List<Question> get questions {
//     final subList = Get.find<DataController>().subjectData;
//     return filterQues(questiondata, subList);
//   }

//   @override
//   void initState() {
//     selectedOptions = List.filled(questions.length, null);
//     skipped = questions.length;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Quiz'),
//         leading: IconButton(
//           icon: backIcon,
//           onPressed: () {
//             Get.dialog(
//               AlertDialog(
//                 title: const Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Text("Do you want to Quit?"),
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     child: const Text("Cancel"),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Get.to(() => const HomePage());
//                     },
//                     child: const Text("OK"),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: questions.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     questions[index].questionText,
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   ...questions[index].options.asMap().entries.map((entry) {
//                     int idx = entry.key;
//                     String option = entry.value;
//                     return RadioListTile<int>(
//                       title: Text(option),
//                       value: idx + 1,
//                       groupValue: selectedOptions[index], // Update to map
//                       onChanged: (value) {
//                         if (selectedOptions[index] != value) {
//                           setState(() {
//                             if (selectedOptions[index] == null) {
//                               selectedOptions[index] = value!;
//                               skipped--;
//                               // print(selectedOptions);
//                               // print(selectedOptions[index].runtimeType);
//                               // print(index);
//                               // // print(questions[index].correctAnswer);
//                               // print(questions[index].options[value - 1]);
//                               if (questions[index].options[value - 1] ==
//                                   questions[index].correctAnswer) {
//                                 finalMark++;
//                                 correct++;
//                               } else {
//                                 finalMark -= 0.25;
//                                 incorrect++;
//                               }
//                               //     //   print(
//                               //     //       'Total marks:$finalMark, Correct: $correct, Incorrect: $incorrect, Skipped: $skipped');
//                             }
//                           });
//                         }
//                       },
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomAppBar(
//         // height: MediaQuery.sizeOf(context).height * 0.06,
//         child: SizedBox(
//           width: MediaQuery.sizeOf(context).width * 0.8,
//           child: ElevatedButton(
//             onPressed: () {
//               Get.dialog(
//                 AlertDialog(
//                   title: const Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Text("Do you want to Submit?"),
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       child: const Text("Cancel"),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Get.find<DataController>().setData({
//                           'totalQuestion': questions.length,
//                           'correctAns': correct,
//                           'incorrectAns': incorrect,
//                           'skippedAns': skipped,
//                         });
//                         Get.to(() => const ResultPage());
//                       },
//                       child: const Text("OK"),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             child: const Padding(
//               padding: EdgeInsets.all(10),
//               child: Text(
//                 'Submit',
//                 style: TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
