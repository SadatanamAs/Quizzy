import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:Quizzy/main.dart';
import 'package:Quizzy/models/question_model.dart';
import 'package:Quizzy/pages/ques_page.dart';
import 'package:Quizzy/question_database.dart';

class CardBuilder extends StatelessWidget {
  final List<String> titles;

  // Constructor that takes titles as a parameter
  const CardBuilder({super.key, required this.titles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: const Icon(FontAwesomeIcons.brain, size: 40),
              title: Text(titles[index], style: const TextStyle(fontSize: 20)),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                List<Subject> cardSelectedList() {
                  List<Subject> selectedSubjects = [];
                  if (subjectInfo.containsKey(titles[index])) {
                    // Iterate through the chapters to create Subject instances
                    final subject = Subject(
                      chapterCode: '', // Use formatted chapter code
                      subCode: subjectInfo[
                          titles[index]], // Get subCode from subjectInfo
                    );
                    selectedSubjects.add(subject);
                  }
                  // print(selectedSubjects);
                  return selectedSubjects;
                }

                var subData = cardSelectedList();
                Get.find<DataController>().setSubject(subData);
                Get.to(() => const QuestionPage());
              },
            ),
          );
        });
  }
}

mixin ActiveSubjects {
  late List<String> subjects = [];
  late Map<String, List<String>> subList4Choice;
  late List<String> allsubjects = subMap.values.toList();

  void findMatchingKeys() {
    subjectInputs();
    subjects.clear();
    for (var item in allsubjects) {
      if (subList4Choice.containsKey(item)) {
        subjects.add(item);
      }
    }
  }
}
