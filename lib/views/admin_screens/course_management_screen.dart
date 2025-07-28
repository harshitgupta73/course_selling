// import 'package:course_app/controllers/course_controller.dart';
// import 'package:course_app/models/subject.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'course_detail_screen.dart';
// import 'add_edit_course_screen.dart';

// class CourseManagementScreen extends StatelessWidget {
//   final CourseController courseController = Get.find<CourseController>();
//   final Category? initialCategory; // Add this

//   CourseManagementScreen({Key? key, this.initialCategory}) : super(key: key) {
//     // Set the initial category if provided
//     if (initialCategory != null) {
//       courseController.filterByCategory(initialCategory);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Manage Courses'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () => Get.to(() => AddEditCourseScreen()),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search courses...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onChanged: (value) => courseController.searchCourses(value),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               children: [
//                 const Text('Filter by category: '),
//                 const SizedBox(width: 8),
//                 Obx(() => DropdownButton<Category>(
//                       value: courseController.selectedCategory.value,
//                       hint: const Text('All'),
//                       items: courseController.categories
//                           .map((category) => DropdownMenuItem<Category>(
//                                 value: category,
//                                 child: Text(category.name),
//                               ))
//                           .toList(),
//                       onChanged: (value) {
//                         courseController.filterByCategory(value);
//                       },
//                     )),
//               ],
//             ),
//           ),
//           // ...existing code...
//           Expanded(
//             child: Obx(() {
//               if (courseController.filteredCourses.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     'No item found',
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                 );
//               }
//               return ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: courseController.filteredCourses.length,
//                 itemBuilder: (context, index) {
//                   final course = courseController.filteredCourses[index];
//                   return _buildCourseCard(course, context);
//                 },
//               );
//             }),
//           ),
// // ...existing code...
//         ],
//       ),
//     );
//   }

//   Widget _buildCourseCard(Course course, BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () => Get.to(() => CourseDetail(course: course)),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       course.imageUrl,
//                       width: 80,
//                       height: 60,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         width: 80,
//                         height: 60,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.image_not_supported),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           course.name,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           '\$${course.price.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.green[600],
//                             fontWeight: FontWeight.w600,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             Icon(Icons.star, color: Colors.orange, size: 16),
//                             Text(' ${course.rating}'),
//                             const SizedBox(width: 16),
//                             Icon(Icons.people, color: Colors.blue, size: 16),
//                             Text(' ${course.students}'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 course.description,
//                 style: TextStyle(color: Colors.grey[600]),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 12),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Chapters: ${course.chapters.length}',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 18,
//                         ),
//                         TextButton.icon(
//                           icon: const Icon(Icons.edit),
//                           label: const Text('Edit'),
//                           onPressed: () =>
//                               Get.to(() => AddEditCourseScreen(course: course)),
//                         ),
//                         TextButton.icon(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           label: const Text('Delete',
//                               style: TextStyle(color: Colors.red)),
//                           onPressed: () => _showDeleteDialog(course, context),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showDeleteDialog(Course course, BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Course'),
//         content: Text('Are you sure you want to delete "${course.name}"?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               // Remove from all categories
//               for (var category in courseController.categories) {
//                 category.courses.remove(course);
//               }
//               courseController.filteredCourses.remove(course);
//               Navigator.pop(context);
//               Get.snackbar(
//                 'Success',
//                 'Course deleted successfully',
//                 backgroundColor: Colors.green,
//                 colorText: Colors.white,
//               );
//             },
//             child: const Text('Delete', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/models/category.dart';
import 'package:course_app/models/chapter.dart';
import 'package:course_app/models/subject.dart';
import 'package:course_app/services/subject_services.dart';
import 'package:course_app/views/admin_screens/course_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_edit_course_screen.dart';

class SubjectManagementScreen extends StatelessWidget {
  final CourseController courseController = Get.find<CourseController>();
  final Category? initialCategory;

  SubjectManagementScreen({Key? key, this.initialCategory}) : super(key: key) {
    if (initialCategory != null) {
      courseController.filterSubjectsByCategory(initialCategory);
    }
  }

  final SubjectServices subjectServices = SubjectServices();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Subjects'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Get.to(() => AddEditSubjectScreen()),
          ),
        ],
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            SizedBox(
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
                          courseController.filterSubjectsByCategory(value);
                        },
                      )),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (courseController.filteredSubjects.isEmpty) {
                  return const Center(
                    child: Text(
                      'No item found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: courseController.filteredSubjects.length,
                  itemBuilder: (context, index) {
                    final subject = courseController.filteredSubjects[index];
                    return _buildSubjectCard(subject, context);
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSubjectCard(Subject subject, BuildContext context) {
    final CourseController controller = Get.find<CourseController>();
    // Filter chapters by subject
    final List<Chapter> subjectChapters = controller.chapters
        .where((chapter) => chapter.subject == subject.name)
        .toList();
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Get.to(() => SubjectDetail(subject: subject)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      subject.image ?? '',
                      width: 80,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 80,
                        height: 60,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subject.category ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green[600],
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subject.description ?? '',
                          style: TextStyle(color: Colors.grey[600]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chapters: ${subjectChapters.length ?? 0}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'),
                        onPressed: () => Get.to(
                            () => AddEditSubjectScreen(subject: subject)),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text('Delete',
                            style: TextStyle(color: Colors.red)),
                        onPressed: () => _showDeleteDialog(subject, context),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(Subject subject, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Subject'),
        content: Text('Are you sure you want to delete "${subject.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await subjectServices.deleteSubject(subject.id!);
              Navigator.pop(context);
              Get.snackbar(
                'Success',
                'Subject deleted successfully',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
              courseController.loadSubjects();
              courseController.filterSubjectsByCategory(
                  courseController.selectedCategory.value);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
