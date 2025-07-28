import 'dart:io';

import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/controllers/file_picker_controller.dart';
import 'package:course_app/models/category.dart';
import 'package:course_app/models/chapter.dart';
import 'package:course_app/models/subject.dart';
import 'package:course_app/services/chapter_services.dart';
import 'package:course_app/services/storage_services.dart';
import 'package:course_app/views/admin_screens/course_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllChaptersManagementScreen extends StatefulWidget {
  final Category? initialCategory;
  final Subject? initialSubject;

  AllChaptersManagementScreen({
    Key? key,
    this.initialCategory,
    this.initialSubject,
  }) : super(key: key);

  @override
  State<AllChaptersManagementScreen> createState() =>
      _AllChaptersManagementScreenState();
}

class _AllChaptersManagementScreenState
    extends State<AllChaptersManagementScreen> {
  final CourseController courseController = Get.find<CourseController>();

  final FilePickerController filePickerController =
      Get.put(FilePickerController());

  final ChapterService chapterService = ChapterService();
  final StorageServices storageServices = StorageServices();

  void _initializeFilters() {
    if (widget.initialCategory != null) {
      courseController.selectedCategory.value = widget.initialCategory;
      courseController.filterSubjectsByCategory(widget.initialCategory);
    }
    if (widget.initialSubject != null) {
      courseController.selectedSubject.value = widget.initialSubject;
      courseController.filterChaptersBySubject(widget.initialSubject);
    } else if (widget.initialCategory != null) {
      // If subject is not provided, filter chapters based on category's subjects
      final relevantSubjects = courseController.subjects
          .where((s) => s.category == widget.initialCategory!.name)
          .toList();
      final relevantSubjectNames = relevantSubjects.map((s) => s.name).toSet();
      courseController.filteredChapters.value = courseController.chapters
          .where((c) => relevantSubjectNames.contains(c.subject))
          .toList();
    } else {
      courseController.filteredChapters.value = courseController.chapters;
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    courseController.cleanCategory();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFilters();
    });
    return Obx(() {
      // if (courseController.isLoading.value) {
      //   return const Center(child: CircularProgressIndicator());
      // }
      return Scaffold(
        appBar: AppBar(
          title: const Text("Chapters Management"),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddChapterDialog(),
              tooltip: 'Add New Chapter',
            ),
          ],
        ),
        body: courseController.isLoading.value? Center(child: CircularProgressIndicator(color: Colors.blue,),): SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Text('Filter by category: '),
                      const SizedBox(width: 6),
                      Obx(() => DropdownButton<Category>(
                            value: courseController.selectedCategory.value,
                            hint: const Text('All'),
                            items: courseController.categories
                                .map((category) => DropdownMenuItem<Category>(
                                      value: category,
                                      child: Text(category.name),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              courseController.selectedCategory.value = value;
                              courseController.filterChaptersByCategory(value);
                              courseController.selectedSubject.value = null;
                              courseController.filteredChapters.value =
                                  courseController
                                      .chapters
                                      .where((c) => courseController.subjects
                                          .where((s) => s.category == value?.name)
                                          .map((s) => s.name)
                                          .contains(c.subject))
                                      .toList();
                            },
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Text('Filter by subject: '),
                      const SizedBox(width: 6),
                      Obx(() => DropdownButton<Subject>(
                            value: courseController.selectedSubject.value,
                            hint: const Text('All'),
                            items: courseController.subjects
                                .map((subject) => DropdownMenuItem<Subject>(
                                      value: subject,
                                      child: Text(subject.name),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              courseController.selectedCategory.value = null;
                              courseController.selectedSubject.value = value;
                              courseController.filterChaptersBySubject(value);
                            },
                          )),
                    ],
                  ),
                ),
                Obx(() {
                  if (courseController.filteredChapters.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'No chapters found.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: courseController.filteredChapters.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final chapter = courseController.filteredChapters[index];
                      return _buildChapterCard(chapter, index);
                    },
                  );
                })
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildChapterCard(Chapter chapter, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                chapter.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                chapter.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showEditChapterDialog(chapter, index),
                    tooltip: 'Edit Chapter',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteChapterDialog(chapter, index),
                    tooltip: 'Delete Chapter',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'Duration: ${chapter.duration}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  if (chapter.rating > 0)
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          'Rating: ${chapter.rating.toStringAsFixed(1)}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (chapter.pdf.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf,
                        size: 16, color: Colors.red),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'PDF: ${chapter.pdf}',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
  bool isLoading = false;
  void _showAddChapterDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final durationController = TextEditingController();
    final priceController = TextEditingController(text: '0.0');


    final formKey = GlobalKey<FormState>();

    courseController.cleanCategory();
    courseController.cleanSubject();

    showDialog(
      context: context,
      builder: (context) => isLoading==true ? Center(child: CircularProgressIndicator(color: Colors.blue,),): AlertDialog(
        title: const Text('Add New Chapter'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Chapter Title',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  child: Obx(() => DropdownButton<Category>(
                    value: courseController.selectedCategory.value,
                    hint: Text("Select Category"),
                    items: courseController.categories
                        .map((category) => DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name),
                    ))
                        .toList(),
                    onChanged: (value) {
                      courseController.selectedCategory.value = value;
                    },
                  )),
                ),
                const SizedBox(height: 16),
                Container(
                  child: Obx(() => DropdownButton<Subject>(
                    value: courseController.selectedSubject.value,
                    hint: Text("Select Subject"),
                    items: courseController.subjects
                        .map((sub) => DropdownMenuItem<Subject>(
                      value: sub,
                      child: Text(sub.name),
                    ))
                        .toList(),
                    onChanged: (value) {
                      courseController.selectedSubject.value = value;
                    },
                  )),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: durationController,
                  decoration: const InputDecoration(
                    labelText: 'Duration (e.g., 15 days)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.timer),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter duration';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price (optional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Obx(
                    () => TextButton(
                      onPressed: () {
                        filePickerController.pickFile();
                      },
                      child: filePickerController.filePath.value.isEmpty
                          ? const Text('Upload PDF')
                          : Text("Uploaded"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                isLoading=true;
              });
              if (formKey.currentState!.validate()) {
                if (filePickerController.filePath.value.isNotEmpty) {
                  final file = File(filePickerController.filePath.value);
                  final url = await storageServices.uploadPdf(file);

                  final newChapter = Chapter(
                    name: titleController.text,
                    description: descriptionController.text,
                    duration: int.parse(durationController.text),
                    category: courseController.selectedCategory.value!.name,
                    subject: courseController.selectedSubject.value!.name,
                    price: double.tryParse(priceController.text) ?? 0.0,
                    pdf: url,
                    rating: 0.0,
                    timestamp: DateTime.now(),
                  );

                  await chapterService.addChapter(newChapter);
                } else {
                  Get.snackbar(
                    'Error',
                    'Please upload a PDF file',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
                setState(() {
                  isLoading=false;
                });

                Navigator.pop(context);

                Get.snackbar(
                  'Success',
                  'Chapter added successfully',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 3),
                );
                courseController.loadChapters();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditChapterDialog(Chapter chapter, int index) {
    final titleController = TextEditingController(text: chapter.name);
    final descriptionController =
        TextEditingController(text: chapter.description);
    final durationController = TextEditingController(text: int.parse(chapter.duration as String).toString());
    final priceController =
        TextEditingController(text: chapter.price.toString());

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Chapter'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: isLoading== true ? Center(child: CircularProgressIndicator(),): Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Chapter Title',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  child: Obx(() => DropdownButton<Category>(
                    value: courseController.selectedCategory.value,
                    hint: Text(chapter.category),
                    items: courseController.categories
                        .map((category) => DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name),
                    ))
                        .toList(),
                    onChanged: (value) {
                      courseController.selectedCategory.value = value;
                    },
                  )),
                ),
                const SizedBox(height: 16),
                Container(
                  child: Obx(() => DropdownButton<Subject>(
                    value: courseController.selectedSubject.value,
                    hint: Text(chapter.subject ?? "Select Subject"),
                    items: courseController.subjects
                        .map((sub) => DropdownMenuItem<Subject>(
                      value: sub,
                      child: Text(sub.name),
                    ))
                        .toList(),
                    onChanged: (value) {
                      courseController.selectedSubject.value = value;
                    },
                  )),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: durationController,
                  decoration: const InputDecoration(
                    labelText: 'Duration (e.g., 15 min)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.timer),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter duration';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:  TextButton(
                      onPressed: () {
                        filePickerController.pickFile();
                      },
                      child: Text("Uploaded"),
                    ),

                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
               Navigator.pop(context);
                   filePickerController.clearFile();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                isLoading=true;
              });
              if (formKey.currentState!.validate()) {
                String newPdf;
                if (filePickerController.filePath.value.isNotEmpty ) {
                  File file = File(filePickerController.filePath.value);
                  newPdf = await storageServices.uploadImage(file);
                } else {
                  newPdf = chapter.pdf;
                }

                final newChapter = Chapter(
                  id: chapter.id,
                  name: titleController.text,
                  description: descriptionController.text,
                  duration: int.tryParse(durationController.text) ?? chapter.duration,
                  category: chapter.category ?? courseController.selectedCategory.value!.name,
                  subject:  chapter.subject ?? courseController.selectedSubject.value!.name,
                  price: double.tryParse(priceController.text) ?? chapter.price,
                  pdf: newPdf,
                  rating: 0.0,
                  timestamp: chapter.timestamp,
                );

                await chapterService.updateChapter(chapter.id!, newChapter);
                setState(() {
                  isLoading=false;
                });
                Navigator.pop(context);

                Get.snackbar(
                  'Success',
                  'Chapter updated successfully',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(16),
                );
                courseController.loadChapters();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteChapterDialog(Chapter chapter, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Chapter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.amber,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Are you sure you want to delete "${chapter.name}"?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'This action cannot be undone.',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await chapterService.deleteChapter(chapter.id!);
              Get.back();
              Get.snackbar(
                'Success',
                'Chapter deleted successfully',
                backgroundColor: Colors.green,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(16),
              );
              courseController.loadChapters();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
