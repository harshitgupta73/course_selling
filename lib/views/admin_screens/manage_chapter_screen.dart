import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/course_controller.dart';
import '../../models/chapter.dart';

class AddChapterScreen extends StatefulWidget {
  @override
  _AddChapterScreenState createState() => _AddChapterScreenState();
}

class _AddChapterScreenState extends State<AddChapterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _durationController = TextEditingController();
  final _categoryController = TextEditingController();
  final _subjectController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pdfController = TextEditingController();
  final _ratingController = TextEditingController();

  final CourseController courseController = Get.find();

  bool isLoading = false;

  void _addChapter() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      final chapter = Chapter(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        duration: int.parse(_durationController.text),
        category: _categoryController.text,
        subject: _subjectController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        description: _descriptionController.text,
        pdf: _pdfController.text,
        rating: double.tryParse(_ratingController.text) ?? 0.0,
        timestamp: DateTime.now(),
      );
      courseController.chapters.add(chapter);
      courseController.filteredChapters.add(chapter);
      Get.snackbar('Success', 'Chapter added successfully');
      Navigator.pop(context);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Chapter')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Chapter Name'),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _durationController,
                    decoration: InputDecoration(labelText: 'Duration'),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _categoryController,
                    decoration: InputDecoration(labelText: 'Category'),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _subjectController,
                    decoration: InputDecoration(labelText: 'Subject'),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _pdfController,
                    decoration: InputDecoration(labelText: 'PDF URL'),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _ratingController,
                    decoration: InputDecoration(labelText: 'Rating'),
                    keyboardType: TextInputType.number,
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addChapter,
                    child: Text('Add Chapter'),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}