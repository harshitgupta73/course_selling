// import 'package:course_app/models/chapter.dart';
// import 'package:course_app/models/subject.dart';
// import 'package:course_app/views/admin_screens/add_edit_course_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'chapter_management_screen.dart';

// class CourseDetail extends StatelessWidget {
//   final Subject subject;

//   const CourseDetail({Key? key, required this.subject}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(subject.name),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               Get.to(() => AddEditCourseScreen(subject: subject));
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 subject.image,
//                 width: double.infinity,
//                 height: 200,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => Container(
//                   width: double.infinity,
//                   height: 200,
//                   color: Colors.grey[300],
//                   child: const Icon(Icons.image_not_supported, size: 50),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               subject.name,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               subject.description,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 _buildInfoChip('Price', '\$${subject.price.toStringAsFixed(2)}',
//                     Colors.green),
//                 // const SizedBox(width: 8),
//                 // _buildInfoChip('Rating', '${course.rating}', Colors.orange),
//                 const SizedBox(width: 8),
//                 _buildInfoChip('Students', '${course.students}', Colors.blue),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 _buildInfoChip('Duration', course.duration, Colors.purple),
//                 const SizedBox(width: 8),
//                 _buildInfoChip(
//                     'Chapters', '${course.chapters.length}', Colors.teal),
//               ],
//             ),
//             const SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Chapters',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.edit),
//                   label: const Text('Manage Chapters'),
//                   onPressed: () =>
//                       Get.to(() => ChapterManagementScreen(subject: subject)),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: course.chapters.length,
//               itemBuilder: (context, index) {
//                 final chapter = course.chapters[index];
//                 return _buildChapterCard(chapter, index + 1);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(String label, String value, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Text(
//         '$label: $value',
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }

//   Widget _buildChapterCard(Chapter chapter, int index) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: Colors.indigo,
//           child: Text(
//             '$index',
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),
//         title: Text(chapter.name),
//         subtitle: Text(chapter.description),
//         trailing: Text(
//           chapter.duration,
//           style: TextStyle(
//             color: Colors.grey[600],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:course_app/controllers/course_controller.dart';
// import 'package:course_app/models/chapter.dart';
// import 'package:course_app/models/subject.dart';
// import 'package:course_app/views/admin_screens/add_edit_course_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'chapter_management_screen.dart';

// class SubjectDetail extends StatelessWidget {
//   final Subject subject;

//   const SubjectDetail({Key? key, required this.subject}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final CourseController controller = Get.find<CourseController>();
//     // Filter chapters by subject
//     final List<Chapter> subjectChapters = controller.chapters
//         .where((chapter) => chapter.subject == subject.name)
//         .toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(subject.name),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               Get.to(() => AddEditSubjectScreen(subject: subject));
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 subject.image ?? '',
//                 width: double.infinity,
//                 height: 200,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => Container(
//                   width: double.infinity,
//                   height: 200,
//                   color: Colors.grey[300],
//                   child: const Icon(Icons.image_not_supported, size: 50),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               subject.name,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               subject.description ?? '',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInfoChip(
//                     'Category', subject.category ?? '', Colors.green),
//                 const SizedBox(height: 8),
//                 _buildInfoChip('Chapters', '${subject.chapters?.length ?? 0}',
//                     Colors.teal),
//               ],
//             ),
//             const SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Chapters',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.edit),
//                   label: const Text('Manage Chapters'),
//                   onPressed: () =>
//                       Get.to(() => ChapterManagementScreen(subject: subject)),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             if (subject.chapters != null && subject.chapters!.isNotEmpty)
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: subject.chapters!.length,
//                 itemBuilder: (context, index) {
//                   final chapter = subject.chapters![index];
//                   return _buildChapterCard(chapter, index + 1);
//                 },
//               )
//             else
//               const Text(
//                 'No chapters available.',
//                 style: TextStyle(color: Colors.grey),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(String label, String value, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Text(
//         '$label: $value',
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }

//   Widget _buildChapterCard(Chapter chapter, int index) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: Colors.indigo,
//           child: Text(
//             '$index',
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),
//         title: Text(chapter.name ?? chapter.name ?? ''),
//         subtitle: Text(chapter.description ?? ''),
//         trailing: Text(
//           chapter.duration ?? '',
//           style: TextStyle(
//             color: Colors.grey[600],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/models/chapter.dart';
import 'package:course_app/models/subject.dart';
import 'package:course_app/views/admin_screens/add_edit_course_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chapter_management_screen.dart';

class SubjectDetail extends StatelessWidget {
  final Subject subject;
  final Subject? course;

  const SubjectDetail({Key? key, required this.subject, this.course})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CourseController controller = Get.find<CourseController>();
    // Filter chapters by subject
    final List<Chapter> subjectChapters = controller.chapters
        .where((chapter) => chapter.subject == subject.name)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(subject.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Get.to(() => AddEditSubjectScreen(subject: subject));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                subject.image ?? '',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              subject.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subject.description ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoChip(
                    'Category', subject.category ?? '', Colors.green),
                const SizedBox(height: 8),
                _buildInfoChip(
                    'Chapters', '${subjectChapters.length}', Colors.teal),
              ],
            ),
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chapters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // ElevatedButton.icon(
                //   icon: const Icon(Icons.edit),
                //   label: const Text('Manage Chapters'),
                //   onPressed: () => Get.to(() => ChapterManagementScreen(
                //         subject: subject,
                //       )),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            if (subjectChapters.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subjectChapters.length,
                itemBuilder: (context, index) {
                  final chapter = subjectChapters[index];
                  return _buildChapterCard(chapter, index + 1);
                },
              )
            else
              const Text(
                'No chapters available.',
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildChapterCard(Chapter chapter, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo,
          child: Text(
            '$index',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(chapter.name),
        subtitle: Text(chapter.description),
        trailing: Text(
          chapter.duration.toString(),
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
