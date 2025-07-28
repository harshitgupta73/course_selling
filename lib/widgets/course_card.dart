// import 'package:course_app/widgets/chapters_screen.dart';
// import 'package:course_app/widgets/course_detail_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../models/subject.dart';
// import '../controllers/course_controller.dart';

// class CourseCard extends StatelessWidget {
//   final Course course;
//   final bool showDetails;
//   final VoidCallback? onTap;

//   const CourseCard({
//     Key? key,
//     required this.course,
//     this.showDetails = false,
//     this.onTap, required BorderRadius borderRadius, required Color backgroundColor,
//   }) : super(key: key);

//   // ...existing code...
//   @override
//   Widget build(BuildContext context) {
//     final CourseController courseController = Get.find();

//     return Card(
//       elevation: 6,
//       margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(18),
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: () {
//           Get.to(() => ChaptersScreen(course: course));
//         },
//         borderRadius: BorderRadius.circular(18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Course Image with overlay
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius:
//                       const BorderRadius.vertical(top: Radius.circular(18)),
//                   child: Image.network(
//                     course.imageUrl,
//                     width: double.infinity,
//                     height: 180,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) => Container(
//                       width: double.infinity,
//                       height: 180,
//                       color: Colors.grey[300],
//                       child: const Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.image, size: 50, color: Colors.grey),
//                           Text('Image not available',
//                               style: TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Course Content
//             Padding(
//               padding: const EdgeInsets.all(18),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Course Name
//                   Text(
//                     course.name,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 0.2,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 6),

//                   // Chapter
//                   Text(
//                     course.description,
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.blueGrey[600],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 14),

//                   // Rating and Students
//                   Row(
//                     children: [
//                       Icon(Icons.star_rounded, color: Colors.amber, size: 18),
//                       const SizedBox(width: 4),
//                       Text(
//                         course.rating.toString(),
//                         style: const TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         '• ${course.students} students',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey[600],
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Additional details if showDetails is true
//                   if (showDetails) ...[
//                     const SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Icon(Icons.access_time,
//                             color: Colors.grey[600], size: 16),
//                         const SizedBox(width: 4),
//                         Text(
//                           course.duration,
//                           style:
//                               TextStyle(fontSize: 13, color: Colors.grey[600]),
//                         ),
//                         const SizedBox(width: 18),
//                         Icon(Icons.calendar_today,
//                             color: Colors.grey[600], size: 16),
//                         const SizedBox(width: 4),
//                         Text(
//                           'Expires: ${DateFormat('MMM dd').format(course.expiryDate)}',
//                           style:
//                               TextStyle(fontSize: 13, color: Colors.grey[600]),
//                         ),
//                       ],
//                     ),
//                   ],

//                   const SizedBox(height: 18),

//                   // Buy Button
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () => courseController.buyCourse(course),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepPurpleAccent,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 22, vertical: 12),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           elevation: 2,
//                         ),
//                         icon: const Icon(
//                           Icons.shopping_cart_checkout_rounded,
//                           size: 20,
//                           color: Colors.white,
//                         ),
//                         label: const Text(
//                           'Buy',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// // ...existing code...
// }

import 'package:course_app/widgets/chapters_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/subject.dart';
import '../controllers/course_controller.dart';

class CourseCard extends StatelessWidget {
  final Subject subject;
  final bool showDetails;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;
  final Color backgroundColor;

  const CourseCard({
    Key? key,
    required this.subject,
    this.showDetails = false,
    this.onTap,
    required this.borderRadius,
    required this.backgroundColor,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.find();

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () => Get.to(() => ChaptersScreen(subject: subject)),
        borderRadius: borderRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Image with overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: borderRadius.topLeft),
                  child: Image.network(
                    subject.image,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 180,
                      color: Colors.grey[300],
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 50, color: Colors.grey),
                          Text('Image not available',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Subject Content
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subject Name
                  Text(
                    subject.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Subject Description
                  Text(
                    subject.description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Category
                  Row(
                    children: [
                      Icon(Icons.category, color: Colors.deepPurple, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        subject.category,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  if (showDetails) ...[
                    const SizedBox(height: 10),
                    Text(
                      'More details coming soon...',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],

                  const SizedBox(height: 18),

                  // View Chapters Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () =>
                            Get.to(() => ChaptersScreen(subject: subject)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                        ),
                        icon: const Icon(
                          Icons.menu_book_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'View Chapters',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}