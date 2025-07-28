import 'package:course_app/models/purchase.dart';
import 'package:course_app/widgets/course_detail_screen.dart';
import 'package:course_app/widgets/pdf_viewer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';
import '../controllers/user_controller.dart';
import '../models/subject.dart'; // <-- Add this import
import '../widgets/course_card.dart';

class PurchaseCoursesScreen extends StatelessWidget {
  final CourseController courseController = Get.find<CourseController>();
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.18),
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withOpacity(0.15),
                        child: Icon(Icons.shopping_cart,
                            color: Colors.white, size: 28),
                      ),
                      SizedBox(width: 14),
                      Text(
                        'My Purchases',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
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
                    ],
                  ),
                  // Profile or menu icon (optional, for symmetry)
                  // CircleAvatar(
                  //   radius: 20,
                  //   backgroundColor: Colors.white.withOpacity(0.18),
                  //   child: Icon(Icons.person, color: Colors.white, size: 24),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        final purchases = courseController.purchases
            .where((p) => p.userId == FirebaseAuth.instance.currentUser!.uid)
            .toList();
        print("size = ${purchases.length}");
        if (purchases.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                const Text(
                  'No purchased courses',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Browse courses to get started',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Enrolled',
                      // user.enrolledCourses.length.toString(),
                      purchases.length.toString(),
                      Icons.book,
                      Colors.blue,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'Completed',
                      // user.completedCourses.length.toString(),
                      0.toString(),
                      Icons.check_circle,
                      Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Enrolled Courses
              Text(
                'My Courses',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),

              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: purchases.length,
                  itemBuilder: (context, index) {
                    return _buildPurchasedSubjectCard(purchases[index]);
                  }),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchasedSubjectCard(Purchase purchase) {
    final chapter = courseController.chapters.firstWhere(
      (s) =>
          s.id ==
          purchase.chapterId, // or provide a default Chapter if necessary
    );
    final subject = courseController.subjects.firstWhere(
      (s) =>
          s.name ==
          chapter.subject, // or provide a default Subject if necessary
    );
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: courseController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                Get.to(() => purchase.isExpired
                    ? CourseDetailScreen(subject: subject, chapter: chapter)
                    : PDFViewerScreen(
                        pdfUrl: chapter.pdf,
                        // or pdfPath: course.pdfPath if local
                        title: purchase.chapterName,
                      ));
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.08),
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.all(18),
                child: Row(
                  children: [
                    SizedBox(width: 18),

                    // Course Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  purchase.chapterName,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueGrey[900],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                              ),
                              const Text(
                                "pdf",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red
                                ),
                              ),

                              SizedBox(
                                width: 10,
                              )
                              // if (isCompleted)
                              //   Icon(Icons.verified_rounded,
                              //       color: Colors.green, size: 22),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  chapter.description,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.blueGrey[900],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.blue[600],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  chapter.duration.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              // if (isCompleted)
                              //   Container(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 8, vertical: 4),
                              //     decoration: BoxDecoration(
                              //       color: Colors.green[400],
                              //       borderRadius: BorderRadius.circular(8),
                              //     ),
                              //     child: const Text(
                              //       'Completed',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         fontSize: 11,
                              //         fontWeight: FontWeight.w600,
                              //       ),
                              //     ),
                              //   ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            purchase.isExpired ? 'Expired' : 'Active until ${purchase.endDate.toLocal().toString().split(' ')[0]}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,color: purchase.isExpired ? Colors.red : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
