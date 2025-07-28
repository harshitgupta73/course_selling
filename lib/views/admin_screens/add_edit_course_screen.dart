// import 'package:course_app/controllers/course_controller.dart';
// import 'package:course_app/models/subject.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AddEditCourseScreen extends StatefulWidget {
//   final Course? course;

//   const AddEditCourseScreen({Key? key, this.course, required Subject subject}) : super(key: key);

//   @override
//   State<AddEditCourseScreen> createState() => _AddEditCourseScreenState();
// }

// class _AddEditCourseScreenState extends State<AddEditCourseScreen> {
//   final CourseController courseController = Get.find<CourseController>();
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController _nameController;
//   late TextEditingController _priceController;
//   late TextEditingController _imageUrlController;
//   late TextEditingController _ratingController;
//   late TextEditingController _studentsController;
//   late TextEditingController _durationController;
//   late TextEditingController _descriptionController;
//   late DateTime _expiryDate;

//   bool get isEditing => widget.course != null;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.course?.name ?? '');
//     _priceController =
//         TextEditingController(text: widget.course?.price.toString() ?? '');
//     _imageUrlController =
//         TextEditingController(text: widget.course?.imageUrl ?? '');
//     _ratingController =
//         TextEditingController(text: widget.course?.rating.toString() ?? '');
//     _studentsController =
//         TextEditingController(text: widget.course?.students.toString() ?? '');
//     _durationController =
//         TextEditingController(text: widget.course?.duration ?? '');
//     _descriptionController =
//         TextEditingController(text: widget.course?.description ?? '');
//     _expiryDate = widget.course?.expiryDate ??
//         DateTime.now().add(const Duration(days: 365));
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _priceController.dispose();
//     _imageUrlController.dispose();
//     _ratingController.dispose();
//     _studentsController.dispose();
//     _durationController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isEditing ? 'Edit Course' : 'Add New Course'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         actions: [
//           TextButton(
//             onPressed: _saveCourse,
//             child: const Text(
//               'SAVE',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Course Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter course name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: const InputDecoration(
//                   labelText: 'Description',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter description';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _priceController,
//                       decoration: const InputDecoration(
//                         labelText: 'Price (\$)',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter price';
//                         }
//                         if (double.tryParse(value) == null) {
//                           return 'Please enter valid price';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _durationController,
//                       decoration: const InputDecoration(
//                         labelText: 'Duration',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter duration';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _ratingController,
//                       decoration: const InputDecoration(
//                         labelText: 'Rating (1-5)',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter rating';
//                         }
//                         final rating = double.tryParse(value);
//                         if (rating == null || rating < 1 || rating > 5) {
//                           return 'Rating must be between 1 and 5';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _studentsController,
//                       decoration: const InputDecoration(
//                         labelText: 'Students Enrolled',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter student count';
//                         }
//                         if (int.tryParse(value) == null) {
//                           return 'Please enter valid number';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _imageUrlController,
//                 decoration: const InputDecoration(
//                   labelText: 'Image URL',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter image URL';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               // Card(
//               //   child: ListTile(
//               //     title: const Text('Expiry Date'),
//               //     subtitle: Text('${_expiryDate.day}/${_expiryDate.month}/${_expiryDate.year}'),
//               //     trailing: const Icon(Icons.calendar_today),
//               //     onTap: _selectExpiryDate,
//               //   ),
//               // ),
//               // const SizedBox(height: 24),
//               if (_imageUrlController.text.isNotEmpty)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Preview:',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         _imageUrlController.text,
//                         width: double.infinity,
//                         height: 200,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) => Container(
//                           width: double.infinity,
//                           height: 200,
//                           color: Colors.grey[300],
//                           child:
//                               const Icon(Icons.image_not_supported, size: 50),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ...existing code...

//   void _saveCourse() async {
//     if (_formKey.currentState!.validate()) {
//       final course = Course(
//         id: widget.course?.id ?? DateTime.now().millisecondsSinceEpoch,
//         name: _nameController.text,
//         price: double.parse(_priceController.text),
//         imageUrl: _imageUrlController.text,
//         rating: double.parse(_ratingController.text),
//         students: int.parse(_studentsController.text),
//         duration: _durationController.text,
//         expiryDate: _expiryDate,
//         description: _descriptionController.text,
//         chapters: widget.course?.chapters ?? [],
//       );

//       // Find the selected category to add/update the course
//       final selectedCategory = courseController.selectedCategory.value ??
//           (courseController.categories.isNotEmpty
//               ? courseController.categories.first
//               : null);

//       if (selectedCategory == null) {
//         Get.snackbar(
//           'Error',
//           'No category selected or available.',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       if (isEditing) {
//         // Update course in the correct category
//         final catIndex = courseController.categories.indexWhere(
//             (cat) => cat.courses.any((c) => c.id == widget.course!.id));
//         if (catIndex != -1) {
//           final courseIndex = courseController.categories[catIndex].courses
//               .indexWhere((c) => c.id == widget.course!.id);
//           if (courseIndex != -1) {
//             courseController.categories[catIndex].courses[courseIndex] = course;
//           }
//         }
//         Get.back();
//         await Future.delayed(const Duration(milliseconds: 100));
//         Get.snackbar(
//           'Success',
//           'Course updated successfully',
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       } else {
//         // Add course to the selected category
//         selectedCategory.courses.add(course);
//         // Trigger update for observers
//         courseController.categories.refresh();
//         Get.back();
//         await Future.delayed(const Duration(milliseconds: 100));
//         Get.snackbar(
//           'Success',
//           'Course added successfully',
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }

//       courseController
//           .filterByCategory(courseController.selectedCategory.value);
//     }
//   }
// // ...existing code...
// }

import 'dart:io';

import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/models/category.dart';
import 'package:course_app/models/subject.dart';
import 'package:course_app/services/storage_services.dart';
import 'package:course_app/services/subject_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/image_picker_controller.dart';

class AddEditSubjectScreen extends StatefulWidget {
  final Subject? subject;

  const AddEditSubjectScreen({Key? key, this.subject}) : super(key: key);

  @override
  State<AddEditSubjectScreen> createState() => _AddEditSubjectScreenState();
}

class _AddEditSubjectScreenState extends State<AddEditSubjectScreen> {
  final CourseController courseController = Get.find<CourseController>();
  final SubjectServices subjectServices = SubjectServices();
  final StorageServices storageServices = StorageServices();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  // late TextEditingController _categoryController;

  bool get isEditing => widget.subject != null;

  final ImagePickerController imageController =
      Get.put(ImagePickerController());

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.subject?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.subject?.description ?? '');
    _imageUrlController =
        TextEditingController(text: widget.subject?.image ?? '');
    // _categoryController =
    //     TextEditingController(text: widget.subject?.category ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    // _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Subject' : 'Add New Subject'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () async {
              setState(() => isLoading = true);
              await _saveSubject();
              setState(() => isLoading = false);
            },
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Obx(() => Center(
                            child: imageController.imagePath.value.isEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      imageController.getImage();
                                    },
                                    child: const Text('Select Image'),
                                  )
                                : Image.file(
                                    File(imageController.imagePath.value),
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 200,
                                  ),
                        ))),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Subject Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter subject name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    child: Obx(() => DropdownButton<Category>(
                          value: courseController.selectedCategory.value,
                          hint: Text(widget.subject?.category ?? "Select Category"),
                          items: courseController.categories
                              .map((category) => DropdownMenuItem<Category>(
                                    value: category,
                                    child: Text(category.name),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            courseController.selectedCategory.value = value;
                            courseController
                                .filterChaptersByCategory(value);
                          },
                        )),
                  ),
                  const SizedBox(height: 16),
                  if (_imageUrlController.text.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Preview:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              _imageUrlController.text,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: double.infinity,
                                height: 200,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported,
                                    size: 50),
                              ),
                            )),
                      ],
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

  Future<void> _saveSubject() async {
    if (_formKey.currentState!.validate()) {
      String imageUrl;

      if (imageController.imagePath.value.isNotEmpty) {
        File imageFile = File(imageController.imagePath.value);
        imageUrl = await storageServices.uploadImage(imageFile); // Local path
      } else if (isEditing) {
        imageUrl = widget.subject!.image; // Retain existing
      } else {
        imageUrl =
            'https://as1.ftcdn.net/v2/jpg/05/58/73/12/1000_F_558731213_ilx4NZvbojGEMQDAfw5W2mcJjinZqf6V.jpg'; // Default
      }

      final subject = Subject(
        name: _nameController.text,
        image: imageUrl,
        description: _descriptionController.text,
        category: courseController.selectedCategory.value!.name,
      );
      setState(() {
        isLoading=true;
      });
      if (isEditing) {
        await subjectServices.updateSubject(widget.subject!.id!, subject);

        await courseController.loadSubjects();

        courseController.subjects.refresh();

        Get.back();
        await Future.delayed(const Duration(milliseconds: 100));
        Get.snackbar(
          'Success',
          'Subject updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        courseController
            .filterSubjectsByCategory(courseController.selectedCategory.value);
      } else {

        await subjectServices.addSubject(subject);

        await courseController.loadSubjects();
        Get.back();
        await Future.delayed(const Duration(milliseconds: 100));
        Get.snackbar(
          'Success',
          'Subject added successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        courseController
            .filterSubjectsByCategory(courseController.selectedCategory.value);
      }
      setState(() {
        isLoading=false;
      });
    }
  }
}
