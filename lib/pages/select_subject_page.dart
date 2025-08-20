import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Quizzy/constants.dart';
import 'package:Quizzy/main.dart';
import 'package:Quizzy/models/question_model.dart';
import 'package:Quizzy/pages/home_page.dart';
import 'package:Quizzy/pages/ques_page.dart';
import 'package:Quizzy/question_database.dart';
import 'package:Quizzy/widgets/category_widget.dart';

class SubjectSelectionPage extends StatefulWidget {
  const SubjectSelectionPage({super.key});

  @override
  State<SubjectSelectionPage> createState() => _SubjectSelectionPageState();
}

class _SubjectSelectionPageState extends State<SubjectSelectionPage>
    with ActiveSubjects {
  Map<String, List<String>> selectedChapters = {
    for (var subject in subMap.values.toList()) subject: []
  };

  List<Subject> selectedList() {
    List<Subject> selectedSubjects = [];
    selectedChapters.forEach((subjectName, chapters) {
      if (subjectInfo.containsKey(subjectName)) {
        for (var chapter in chapters) {
          // Extract the chapter number from the chapter string
          String chapterNumber =
              chapter.replaceAll(RegExp(r'[^0-9]'), ''); // Extract only digits
          String formattedChapterCode =
              chapterNumber.padLeft(2, '0'); // Format to 01, 02, etc.

          final subject = Subject(
            chapterCode: formattedChapterCode,
            subCode: subjectInfo[subjectName],
          );
          selectedSubjects.add(subject);
        }
      }
    });
    // print(selectedSubjects);
    return selectedSubjects;
  }

  @override
  void initState() {
    subList4Choice = {
      for (var entry in chapterMap.entries) subMap[entry.key]!: entry.value
    };
    findMatchingKeys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(chapterMap);
    // print(subjects);
    // print(allsubjects);
    // print(subList4Choice);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Select Chapters for Subjects'),
        leading: IconButton(
          icon: backIcon, // Custom back button icon
          onPressed: () {
            // Perform your custom action here
            Get.to(() => const HomePage());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: subjects.map((subject) {
            return ExpansionTile(
              title: Text(subject,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                Wrap(
                  spacing: 8.0,
                  children: subList4Choice[subject]!.map((chapter) {
                    return ChoiceChip(
                      label: Text('Chapter $chapter'),
                      selected:
                          selectedChapters[subject]?.contains(chapter) ?? false,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            if (selectedChapters[subject]!.length < 15) {
                              selectedChapters[subject]!.add(chapter);
                            }
                          } else {
                            selectedChapters[subject]!.remove(chapter);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.923,
        child: FloatingActionButton(
          onPressed: () {
            // print(selectedChapters.values.any((key) => key.isNotEmpty));
            if (selectedChapters.values.any((key) => key.isNotEmpty)) {
              Get.dialog(
                AlertDialog(
                  title: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Do you wish to continue?"),
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
                        Get.back();
                        var subData = selectedList();
                        Get.find<DataController>().setSubject(subData);
                        Get.to(() => const QuestionPage());
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            } else {
              Get.snackbar(
                "No Chapter selected",
                "Please Select a chapter to continue",
                snackPosition: SnackPosition.TOP,
                colorText: Colors.black87,
                duration: const Duration(seconds: 1),
                backgroundColor: Colors.blueAccent,
                overlayColor: Colors.black12,
                overlayBlur: 0.05,
              );
            }
          },
          tooltip: 'Start Quiz',
          child: const Text(
            'Start Quiz',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
