// import 'package:course_app/controllers/course_controller.dart';
// import 'package:course_app/models/subject.dart';
// import 'package:course_app/views/admin_screens/category_management_screen.dart';
// import 'package:course_app/views/admin_screens/course_management_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'analytics_screen.dart';

// class AdminDashboard extends StatelessWidget {
//   final CourseController courseController = Get.find<CourseController>();

//   AdminDashboard({Key? key}) : super(key: key);

//   // Helper to get all courses from all categories
//   List<Course> get _allCourses =>
//       courseController.categories.expand((cat) => cat.courses).toList();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Course Admin Panel'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             tooltip: 'Log Out',
//             onPressed: () {
//               Get.offAllNamed('/');
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Dashboard Overview',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Obx(() => Row(
//                   children: [
//                     Expanded(
//                       child: _buildStatCard(
//                         'Total Courses',
//                         _allCourses.length.toString(),
//                         Icons.book,
//                         Colors.blue,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: _buildStatCard(
//                         'Total Students',
//                         _allCourses
//                             .fold(0, (sum, course) => sum + course.students)
//                             .toString(),
//                         Icons.people,
//                         Colors.green,
//                       ),
//                     ),
//                   ],
//                 )),
//             const SizedBox(height: 16),
//             Obx(() => Row(
//                   children: [
//                     Expanded(
//                       child: _buildStatCard(
//                         'Avg Rating',
//                         (_allCourses.isNotEmpty
//                                 ? (_allCourses.fold(0.0,
//                                         (sum, course) => sum + course.rating) /
//                                     _allCourses.length)
//                                 : 0.0)
//                             .toStringAsFixed(1),
//                         Icons.star,
//                         Colors.orange,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: _buildStatCard(
//                         'Categories',
//                         courseController.categories.length.toString(),
//                         Icons.category,
//                         Colors.purple,
//                       ),
//                     ),
//                   ],
//                 )),
//             const SizedBox(height: 30),
//             const Text(
//               'Quick Actions',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 children: [
//                   _buildActionCard(
//                     'Categories',
//                     Icons.category,
//                     Colors.orange,
//                     () => Get.to(() => CategoryManagementScreen()),
//                   ),
//                   _buildActionCard(
//                     'Analytics',
//                     Icons.analytics,
//                     Colors.green,
//                     () => Get.to(() => AnalyticsScreen()),
//                   ),
//                   _buildActionCard(
//                     'Manage Courses',
//                     Icons.school,
//                     Colors.blue,
//                     () => Get.to(() => CourseManagementScreen()),
//                   ),
//                   _buildActionCard(
//                     'Settings',
//                     Icons.settings,
//                     Colors.grey,
//                     () => _showSettingsDialog(context),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard(
//       String title, String value, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(16),
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
//               Icon(icon, color: color, size: 24),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 24,
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
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionCard(
//       String title, IconData icon, Color color, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: color),
//             const SizedBox(height: 12),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showSettingsDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Settings'),
//         content: const Text('Settings panel coming soon!'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/controllers/users_controller.dart';
import 'package:course_app/models/subject.dart';
import 'package:course_app/views/admin_login_screen.dart';
import 'package:course_app/views/admin_screens/all_chapters_management_screen.dart';
import 'package:course_app/views/admin_screens/all_users_screen.dart';
import 'package:course_app/views/admin_screens/banner_screen.dart';
import 'package:course_app/views/admin_screens/category_management_screen.dart';
import 'package:course_app/views/admin_screens/course_management_screen.dart';
import 'package:course_app/views/admin_screens/update_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final CourseController courseController = Get.put(CourseController());
  final UsersController usersController = Get.put(UsersController());

  List<Subject> get _allSubjects => courseController.subjects.toList();

  @override
  void initState() {
    courseController.calculatePrice(null);
    super.initState();
    print("dhvhdj= ${courseController.totalPrice.toStringAsFixed(2)}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Admin Panel'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log Out',
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Get.offAll(() => AdminLoginScreen());
                Get.snackbar(
                  'Success',
                  'Logged out successfully',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Failed to logout',
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Dashboard Panel',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildActionCard(
                    'Manage Categories',
                    "Categories: ${courseController.categories.length.toString()}",
                    Icons.type_specimen,
                    Colors.blue,
                    () => Get.to(() => const CategoryManagementScreen()),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildActionCard(
                    'Manage Subjects',
                    "Subjects: ${_allSubjects.length.toString()}",
                    Icons.bookmark_add_rounded,
                    Colors.blue,
                    () => Get.to(() => SubjectManagementScreen()),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildActionCard(
                    'Manage Chapters',
                    "Chapters: ${courseController.chapters.length.toString()}",
                    Icons.menu_book_sharp,
                    Colors.blue,
                    () => Get.to(() => AllChaptersManagementScreen()),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildActionCard(
                    'Manage Banners',
                    "Add or Delete Banners",
                    Icons.menu_book_sharp,
                    Colors.blue,
                    () => Get.to(() => const BannerScreen()),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => AllUsersScreen()),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.person_outline_outlined,
                              size: 40, color: Colors.blue),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'No of Users Registered',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Users: ${usersController.users.length.toString()}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Total Income:${courseController.totalPrice.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildActionCard(
                    'Manage Razorpay key',
                    "Add or Delete Key",
                    Icons.key_sharp,
                    Colors.blue,
                        () => Get.to(() => const UpdateKey()),
                  ),
                ],
              ),
            ),
          );
      }),
    );
  }

  Widget _buildActionCard(String title, String value, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
