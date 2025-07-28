import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/controllers/user_controller.dart';
import 'package:course_app/models/purchase.dart';
import 'package:course_app/models/user.dart';
import 'package:course_app/widgets/pdf_viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPurchaseScreen extends StatefulWidget {
  final User user;
  UserPurchaseScreen(this.user, {super.key});

  @override
  State<UserPurchaseScreen> createState() => _UserPurchaseScreenState();
}



class _UserPurchaseScreenState extends State<UserPurchaseScreen> {
  final CourseController courseController = Get.find<CourseController>();

  final UserController userController = Get.find();

  // var paymentDoneByUser = 0.0;
  @override
  void initState() {
    // courseController.calculatePrice(widget.user.id);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      courseController.calculatePrice(widget.user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('${widget.user.name} Purchases'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body : Obx(() {
        final purchases = courseController.purchases
            .where((p) => p.userId == widget.user.id)
            .toList();
        if (purchases.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
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
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 8,),
              Text(
                "Total Price: ${courseController.totalPricePerUser.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),


              SizedBox(height: 8),

              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: purchases.length,
                  itemBuilder: (context, index) {
                    // totalPrice.value += purchases[index].price;
                    return _buildPurchasedSubjectCard(purchases[index]);
                  }),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPurchasedSubjectCard(Purchase purchase) {
    final chapter = courseController.chapters.firstWhere(
          (s) =>
      s.id ==
          purchase.chapterId, // or provide a default Chapter if necessary
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
          Get.to(() => PDFViewerScreen(
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
