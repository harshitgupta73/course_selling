// import 'package:course_app/controllers/course_controller.dart';
// import 'package:course_app/models/subject.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AnalyticsScreen extends StatelessWidget {
//   final CourseController courseController = Get.find<CourseController>();

//   AnalyticsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Analytics'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Course Analytics',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Obx(() => _buildOverviewCards()),
//             const SizedBox(height: 24),
//             const Text(
//               'Top Performing Courses',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Obx(() => _buildTopCourses()),
//             const SizedBox(height: 24),
//             const Text(
//               'Category Distribution',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Obx(() => _buildCategoryStats()),
//           ],
//         ),
//       ),
//     );
//   }

//   // Use all courses from all categories
//   List<Course> get _allCourses =>
//       courseController.categories.expand((cat) => cat.courses).toList();

//   Widget _buildOverviewCards() {
//     final courses = _allCourses;
//     final totalRevenue = courses.fold(
//         0.0, (sum, course) => sum + (course.price * course.students));
//     final avgRating = courses.isNotEmpty
//         ? courses.fold(0.0, (sum, course) => sum + course.rating) /
//             courses.length
//         : 0.0;
//     final totalStudents =
//         courses.fold(0, (sum, course) => sum + course.students);

//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: _buildAnalyticsCard(
//                 'Total Revenue',
//                 '${totalRevenue.toStringAsFixed(0)}',
//                 Icons.attach_money,
//                 Colors.green,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: _buildAnalyticsCard(
//                 'Avg Rating',
//                 avgRating.toStringAsFixed(1),
//                 Icons.star,
//                 Colors.orange,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: _buildAnalyticsCard(
//                 'Total Students',
//                 totalStudents.toString(),
//                 Icons.people,
//                 Colors.blue,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: _buildAnalyticsCard(
//                 'Active Courses',
//                 courses.length.toString(),
//                 Icons.school,
//                 Colors.purple,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildAnalyticsCard(
//       String title, String value, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Icon(icon, color: color, size: 28),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTopCourses() {
//     final courses = _allCourses;
//     final sortedCourses = List.from(courses)
//       ..sort(
//           (a, b) => (b.rating * b.students).compareTo(a.rating * a.students));
//     final topCourses = sortedCourses.take(5).toList();

//     return Column(
//       children: topCourses
//           .map((course) => Card(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 child: ListTile(
//                   leading: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       course.imageUrl,
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         width: 50,
//                         height: 50,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.image_not_supported),
//                       ),
//                     ),
//                   ),
//                   title: Text(course.name),
//                   subtitle:
//                       Text('${course.students} students • ${course.rating} ⭐'),
//                   trailing: Text(
//                     '\$${course.price.toStringAsFixed(0)}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ))
//           .toList(),
//     );
//   }

//   Widget _buildCategoryStats() {
//     final categoryStats = <String, int>{};
//     for (final category in courseController.categories) {
//       categoryStats[category.name] = category.courses.length;
//     }

//     return Column(
//       children: categoryStats.entries
//           .map((entry) => Card(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 child: ListTile(
//                   leading: const Icon(Icons.category),
//                   title: Text(entry.key),
//                   trailing: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.indigo.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       '${entry.value} courses',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.indigo,
//                       ),
//                     ),
//                   ),
//                 ),
//               ))
//           .toList(),
//     );
//   }
// }

import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalyticsScreen extends StatelessWidget {
  final CourseController courseController = Get.find<CourseController>();

  AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Subject Analytics',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => _buildOverviewCards()),
              const SizedBox(height: 24),
              const Text(
                'Top Performing Subjects',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => _buildTopSubjects()),
              const SizedBox(height: 24),
              const Text(
                'Category Distribution',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => _buildCategoryStats()),
            ],
          ),
        );
      }),
    );
  }

  List<Subject> get _allSubjects => courseController.subjects.toList();

  Widget _buildOverviewCards() {
    final subjects = _allSubjects;
    final totalChapters = courseController.chapters.length;
    final avgRating = subjects.isNotEmpty
        ? subjects.fold(0.0, (sum, subject) => sum + (4.0)) /
            subjects.length
        : 0.0;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildAnalyticsCard(
                'Total Subjects',
                '${subjects.length}',
                Icons.book,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildAnalyticsCard(
                'Avg Rating',
                avgRating.toStringAsFixed(1),
                Icons.star,
                Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildAnalyticsCard(
                'Total Chapters',
                totalChapters.toString(),
                Icons.people,
                Colors.green,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildAnalyticsCard(
                'Active Subjects',
                subjects.length.toString(),
                Icons.school,
                Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 28),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSubjects() {
    final subjects = _allSubjects;
    final sortedSubjects = List.from(subjects)
      ..sort((a, b) => ((4.0)).compareTo((4.0)));
    final topSubjects = sortedSubjects.take(5).toList();

    return Column(
      children: topSubjects
          .map((subject) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      subject.image ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  title: Text(subject.name),
                  subtitle: Text(subject.category ?? ''),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCategoryStats() {
    final categoryStats = <String, int>{};
    for (final subject in courseController.subjects) {
      categoryStats[subject.category ?? 'Uncategorized'] =
          (categoryStats[subject.category ?? 'Uncategorized'] ?? 0) + 1;
    }

    return Column(
      children: categoryStats.entries
          .map((entry) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.category),
                  title: Text(entry.key),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${entry.value} subjects',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
