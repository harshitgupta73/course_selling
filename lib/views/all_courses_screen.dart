// import 'package:course_app/models/subject.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../controllers/course_controller.dart';
// import '../widgets/course_card.dart';
// import '../widgets/search_bar.dart';

// class AllCoursesScreen extends StatelessWidget {
//   final CourseController courseController = Get.find();

//   final Color primaryColor = const Color(0xFF2563EB);
//   final Color accentColor = const Color(0xFFF59E42);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FA),
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70),
//         child: Container(
//           decoration: BoxDecoration(
//             color: primaryColor,
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(24),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.blue.withOpacity(0.15),
//                 blurRadius: 16,
//                 offset: Offset(0, 8),
//               ),
//             ],
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//               child: Row(
//                 children: [
//                   Flexible(
//                     child: Text(
//                       'All Courses',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.2,
//                         shadows: [
//                           Shadow(
//                             color: Colors.black26,
//                             blurRadius: 4,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                   ),
//                   // Spacer(),
//                   SizedBox(width: 5),
//                   Obx(() {
//                     return _ModernDropdown(
//                       categories: courseController.categories,
//                       selected: courseController.selectedCategory.value,
//                       onSelected: (cat) {
//                         courseController.filterByCategory(cat);
//                       },
//                       primaryColor: primaryColor,
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(18),
//         child: Column(
//           children: [
//             // Modern Search Bar
//             Material(
//               elevation: 2,
//               borderRadius: BorderRadius.circular(12),
//               child: CustomSearchBar(
//                 onChanged: courseController.searchCourses,
//                 hintText: 'Search all courses...',
//                 backgroundColor: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 prefixIcon: Icon(Icons.search, color: primaryColor),
//               ),
//             ),
//             SizedBox(height: 20),

//             // Course List
//             Expanded(
//               child: Obx(() {
//                 if (courseController.isLoading.value) {
//                   return Center(
//                       child: CircularProgressIndicator(color: primaryColor));
//                 }

//                 if (courseController.filteredCourses.isEmpty) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.search_off,
//                           size: 64,
//                           color: Colors.grey[400],
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           'No courses found',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.grey[500],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: courseController.filteredCourses.length,
//                   itemBuilder: (context, index) {
//                     final course = courseController.filteredCourses[index];
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 18),
//                       child: Material(
//                         // elevation: 3,
//                         // borderRadius: BorderRadius.circular(18),
//                         child: CourseCard(
//                           course: course,
//                           showDetails: true,
//                           onTap: () => _showCourseDetails(context, course),
//                           borderRadius: BorderRadius.circular(18),
//                           backgroundColor: Colors.white,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showCourseDetails(BuildContext context, course) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) => DraggableScrollableSheet(
//         initialChildSize: 0.75,
//         maxChildSize: 0.95,
//         minChildSize: 0.5,
//         expand: false,
//         builder: (context, scrollController) => SingleChildScrollView(
//           controller: scrollController,
//           padding: EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 5,
//                   margin: EdgeInsets.only(bottom: 18),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(2.5),
//                   ),
//                 ),
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.network(
//                   course.imageUrl,
//                   width: double.infinity,
//                   height: 200,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     width: double.infinity,
//                     height: 200,
//                     color: Colors.grey[200],
//                     child: Icon(Icons.image, size: 50, color: Colors.grey),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 18),
//               Text(
//                 course.name,
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: primaryColor,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 course.description,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[700],
//                   height: 1.5,
//                 ),
//               ),
//               SizedBox(height: 18),
//               Row(
//                 children: [
//                   Icon(Icons.star, color: Colors.amber, size: 20),
//                   SizedBox(width: 4),
//                   Text('${course.rating}',
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                   SizedBox(width: 16),
//                   Icon(Icons.people, color: Colors.grey, size: 20),
//                   SizedBox(width: 4),
//                   Text('${course.students} students'),
//                   SizedBox(width: 16),
//                   Icon(Icons.access_time, color: Colors.grey, size: 20),
//                   SizedBox(width: 4),
//                   Text(course.duration),
//                 ],
//               ),
//               SizedBox(height: 18),
//               Container(
//                 padding: EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: accentColor.withOpacity(0.08),
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: accentColor.withOpacity(0.2)),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.schedule, color: accentColor),
//                     SizedBox(width: 8),
//                     Text(
//                       'Expires: ${DateFormat('MMM dd, yyyy').format(course.expiryDate)}',
//                       style: TextStyle(
//                         color: accentColor,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 18),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Price',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         Text(
//                           '\$${course.price.toStringAsFixed(0)}',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: primaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         courseController.buyCourse(course);
//                         Navigator.pop(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         elevation: 2,
//                       ),
//                       child: Text(
//                         'Buy Course',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // --- Modern Dropdown Widget ---
// class _ModernDropdown extends StatelessWidget {
//   final List<Category> categories;
//   final Category? selected;
//   final Function(Category?) onSelected;
//   final Color primaryColor;

//   const _ModernDropdown({
//     required this.categories,
//     required this.selected,
//     required this.onSelected,
//     required this.primaryColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<Category?>(
//       tooltip: "Filter by Category",
//       offset: Offset(0, 40),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       color: Colors.white,
//       elevation: 8,
//       icon: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.15),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.filter_list, color: Colors.white, size: 22),
//             SizedBox(width: 6),
//             Flexible(
//               child: Text(
//                 selected?.name ?? "All",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//             ),
//             Icon(Icons.arrow_drop_down, color: Colors.white),
//           ],
//         ),
//       ),
//       itemBuilder: (context) => [
//         PopupMenuItem<Category?>(
//           value: null,
//           child: Row(
//             children: [
//               Icon(Icons.apps, color: primaryColor),
//               SizedBox(width: 8),
//               Text("All", style: TextStyle(fontWeight: FontWeight.w600)),
//             ],
//           ),
//         ),
//         ...categories.map((cat) => PopupMenuItem<Category?>(
//               value: cat,
//               child: Row(
//                 children: [
//                   Icon(Icons.label, color: primaryColor),
//                   SizedBox(width: 8),
//                   Text(cat.name, style: TextStyle(fontWeight: FontWeight.w600)),
//                 ],
//               ),
//             )),
//       ],
//       onSelected: onSelected,
//     );
//   }
// }

import 'package:course_app/views/subject_screen.dart';
import 'package:course_app/widgets/chapters_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/course_controller.dart';
import '../models/category.dart';
import '../models/subject.dart';
import '../widgets/search_bar.dart';

class AllCoursesScreen extends StatelessWidget {
  final CourseController courseController = Get.find();

  final Color primaryColor = const Color(0xFF2563EB);
  final Color accentColor = const Color(0xFFF59E42);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.15),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'All Categories',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 5),
                  // Obx(() {
                  //   return _ModernDropdown(
                  //     categories: courseController.categories,
                  //     selected: courseController.selectedCategory.value,
                  //     onSelected: (cat) {
                  //       courseController.filterSubjectsByCategory(cat);
                  //     },
                  //     primaryColor: primaryColor,
                  //   );
                  // }),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            // Modern Search Bar
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: CustomSearchBar(
                onChanged: courseController.searchSubjects,
                hintText: 'Search all categories...',
                backgroundColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                prefixIcon: Icon(Icons.search, color: primaryColor),
              ),
            ),
            SizedBox(height: 20),

            // Course List
            Expanded(
              child: Obx(() {
                if (courseController.isLoading.value) {
                  return Center(
                      child: CircularProgressIndicator(color: primaryColor));
                }

                if (courseController.categories.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No categories found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: courseController.categories.length,
                  itemBuilder: (context, index) {
                    final category = courseController.categories[index];
                    // Count subjects in this category
                    final subjectCount = courseController.subjects
                        .where((s) => s.category == category.name)
                        .length;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 18),
                      child: Material(
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              category.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey[200],
                                child: Icon(Icons.image,
                                    size: 30, color: Colors.grey),
                              ),
                            ),
                          ),
                          title: Text(category.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor)),
                          subtitle: Text(
                            "Subects : $subjectCount",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // ...existing code...
                          onTap: () =>
                              Get.to(() => SubjectScreen(category: category)),
// ...existing code...
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showCourseDetails(BuildContext context, Subject subject) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  subject.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Text(
                subject.name,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                subject.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              SizedBox(height: 18),
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: accentColor.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.category, color: accentColor),
                    SizedBox(width: 8),
                    Text(
                      subject.category,
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    'Enroll Successful',
                    'You have enrolled in ${subject.name}',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Enroll',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Modern Dropdown Widget ---
class _ModernDropdown extends StatelessWidget {
  final List<Category> categories;
  final Category? selected;
  final Function(Category?) onSelected;
  final Color primaryColor;

  const _ModernDropdown({
    required this.categories,
    required this.selected,
    required this.onSelected,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Category?>(
      tooltip: "Filter by Category",
      offset: Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      elevation: 8,
      icon: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.filter_list, color: Colors.white, size: 22),
            SizedBox(width: 6),
            Flexible(
              child: Text(
                selected?.name ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem<Category?>(
          value: null,
          child: Row(
            children: [
              Icon(Icons.apps, color: primaryColor),
              SizedBox(width: 8),
              Text("", style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        ...categories.map((cat) => PopupMenuItem<Category?>(
              value: cat,
              child: Row(
                children: [
                  Icon(Icons.label, color: primaryColor),
                  SizedBox(width: 8),
                  Text(cat.name, style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            )),
      ],
      onSelected: onSelected,
    );
  }
}
