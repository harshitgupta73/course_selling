// import 'package:course_app/models/chapter.dart';
// import 'package:course_app/widgets/course_detail_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/subject.dart';

// class ChaptersScreen extends StatelessWidget {
//   final Subject course;

//   const ChaptersScreen({Key? key, required this.course}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final chapters = course.chapter;

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: CustomScrollView(
//         slivers: [
//           // App Bar with Course Info
//           SliverAppBar(
//             expandedHeight: 280,
//             floating: false,
//             pinned: true,
//             backgroundColor: Colors.deepPurpleAccent,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.deepPurpleAccent,
//                       Colors.deepPurpleAccent.withOpacity(0.8),
//                     ],
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           course.name,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Icon(Icons.star, color: Colors.amber, size: 18),
//                             const SizedBox(width: 4),
//                             Text(
//                               '${course.rating}',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Text(
//                               '${course.students} students',
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.9),
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Chapters List
//           SliverPadding(
//             padding: const EdgeInsets.all(16),
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final chapter = chapters[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: ChapterCard(
//                       chapter: chapter,
//                       chapterNumber: index + 1,
//                       onTap: () => _navigateToChapter(context, chapter),
//                     ),
//                   );
//                 },
//                 childCount: chapters.length,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _navigateToChapter(BuildContext context, Chapter chapter) {
//     // Navigate to chapter content screen
//     Get.to(() => CourseDetailScreen(course: course,chapter: chapter));
//     // For now, show a snackbar
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Opening: ${chapter.name}'),
//         backgroundColor: Colors.deepPurpleAccent,
//       ),
//     );
//   }
// }

// class ChapterCard extends StatelessWidget {
//   final Chapter chapter;
//   final int chapterNumber;
//   final VoidCallback? onTap;

//   const ChapterCard({
//     Key? key,
//     required this.chapter,
//     required this.chapterNumber,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               // Chapter Number/Status Icon
//               Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _getStatusColor(),
//                 ),
//                 child: Center(
//                   child: _getStatusIcon(),
//                 ),
//               ),
//               const SizedBox(width: 16),

//               // Chapter Info
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       chapter.name,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       chapter.description,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey[600],
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.access_time,
//                           size: 14,
//                           color: Colors.grey[600],
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           chapter.duration,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               // Arrow or Lock Icon
//               Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//                 color: Colors.grey[600],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Color _getStatusColor() {
//     return Colors.deepPurpleAccent.withOpacity(0.1);
//   }

//   Widget _getStatusIcon() {
//     return Text(
//       '$chapterNumber',
//       style: const TextStyle(
//         color: Colors.deepPurpleAccent,
//         fontWeight: FontWeight.bold,
//         fontSize: 16,
//       ),
//     );
//   }
// }

import 'package:course_app/models/chapter.dart';
import 'package:course_app/widgets/course_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/subject.dart';
import '../controllers/course_controller.dart';

class ChaptersScreen extends StatelessWidget {
  final Subject subject;

  const ChaptersScreen({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseController = Get.find<CourseController>();
    final chapters = courseController.chapters
        .where((c) => c.subject == subject.name)
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // App Bar with Subject Info
          SliverAppBar(
            expandedHeight: 280,
            leading: SizedBox(),
            floating: false,
            pinned: true,
            backgroundColor: Colors.deepPurpleAccent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.deepPurpleAccent,
                      Colors.deepPurpleAccent.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            "${subject.name}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subject.category,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              subject.image,
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                  ),
                  ),
                ),
              ),
            ),


          // Chapters List
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final chapter = chapters[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ChapterCard(
                      chapter: chapter,
                      chapterNumber: index + 1,
                      onTap: () => _navigateToChapter(context, chapter),
                    ),
                  );
                },
                childCount: chapters.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToChapter(BuildContext context, Chapter chapter) {
    // Navigate to chapter detail screen
    Get.to(() => CourseDetailScreen(subject: subject, chapter: chapter));
    // Optionally show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening: ${chapter.name}'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}

class ChapterCard extends StatelessWidget {
  final Chapter chapter;
  final int chapterNumber;
  final VoidCallback? onTap;

  const ChapterCard({
    Key? key,
    required this.chapter,
    required this.chapterNumber,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Chapter Number
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.deepPurpleAccent.withOpacity(0.1),
                ),
                child: const Center(
                  child: Icon(Icons.picture_as_pdf,color: Colors.red,size: 40,)
                ),
              ),
              const SizedBox(width: 16),

              // Chapter Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chapter.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      chapter.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          chapter.duration.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow Icon
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
