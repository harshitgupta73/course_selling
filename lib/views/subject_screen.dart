import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/models/category.dart';
import 'package:course_app/models/subject.dart';
import 'package:course_app/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectScreen extends StatefulWidget {
  final Category? category;

  const SubjectScreen({super.key, this.category});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final CourseController courseController = Get.find<CourseController>();

  @override
  void initState() {
    super.initState();

    if (widget.category != null) {
      courseController.filterSubjectsByCategory(widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category!.name),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            final subjects = courseController.filteredSubjects;
            if (subjects.isEmpty) {
              return const Center(child: Text("No subjects available."));
            }

            return ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return CourseCard(
                    subject: subjects[index],
                    borderRadius: BorderRadius.circular(2),
                    backgroundColor: Colors.white,
                  );
                });
          }),
        ));
  }
}
