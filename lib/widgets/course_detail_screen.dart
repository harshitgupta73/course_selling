import 'package:course_app/controllers/user_controller.dart';
import 'package:course_app/controllers/users_controller.dart';
import 'package:course_app/models/purchase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../models/subject.dart';
import '../models/chapter.dart';
import '../controllers/course_controller.dart';

class CourseDetailScreen extends StatefulWidget {
  final Subject subject;
  final Chapter chapter;

  const CourseDetailScreen({
    super.key,
    required this.subject,
    required this.chapter,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  @override
  void dispose() {
    _razorpay.clear(); // Clean up
    super.dispose();
  }

  final CourseController courseController = Get.find();
  final UserController userController = Get.find();
  final UsersController usersController = Get.find();

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Add purchase logic here on successful payment
    Purchase purchase = Purchase(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: FirebaseAuth.instance.currentUser!.uid,
      chapterName: widget.chapter.name,
      chapterId: widget.chapter.id!,
      price: widget.chapter.price,
      purchaseDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: widget.chapter.duration)),
      paymentStatus: "Paid",
    );

    await courseController.addPurchase(purchase);

    Get.snackbar(
      'Success',
      'Chapter purchased successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      'Payment Failed',
      'Error: ${response.message}',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
      'External Wallet',
      'Wallet Name: ${response.walletName}',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final key = usersController.key;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.subject.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 80, color: Colors.grey),
                          Text('Image not available',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chapter.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue.withOpacity(0.3)),
                    ),
                    child: Text(
                      widget.subject.category,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildStatItem(
                        icon: Icons.star,
                        value: widget.chapter.rating.toStringAsFixed(1),
                        label: 'Rating',
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 24),
                      _buildStatItem(
                        icon: Icons.access_time,
                        value: widget.chapter.duration.toString(),
                        label: 'Duration',
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 24),
                      _buildStatItem(
                        icon: Icons.attach_money,
                        value: widget.chapter.price.toStringAsFixed(0),
                        label: 'Price',
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'About this chapter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.chapter.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'All Chapters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Obx(() {
                    final chapters = courseController.chapters
                        .where((c) => c.subject == widget.subject.name)
                        .toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: chapters.length,
                      itemBuilder: (context, index) {
                        final ch = chapters[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const Icon(Icons.book, color: Colors.blue),
                            title: Text(ch.name),
                            subtitle: Text('${ch.duration} • ${ch.category}'),
                            trailing: Text('⭐ ${ch.rating}'),
                            onTap: () {
                              Get.to(() => CourseDetailScreen(
                                    subject: widget.subject,
                                    chapter: ch,
                                  ));
                              courseController.selectChapter(ch);
                            },
                          ),
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 30),
                  const Text(
                    'What you\'ll learn',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeaturesList(),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Chapter Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                            'Duration', widget.chapter.duration.toString()),
                        _buildDetailRow('Category', widget.chapter.category),
                        _buildDetailRow('Subject', widget.chapter.subject),
                        _buildDetailRow(
                            'Rating', '${widget.chapter.rating}/5.0'),
                        _buildDetailRow('Last Updated', ''),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.currency_rupee,
                          color: Colors.blue,
                          size: 24,
                        ),
                        Text(
                          widget.chapter.price.toStringAsFixed(0),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(() {
                final isLoading = courseController.isLoading.value;

                return Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    // onPressed: isLoading ? null : () async {
                    //   Purchase purchase = Purchase(
                    //     id: DateTime.now().millisecondsSinceEpoch.toString(),
                    //     userId: FirebaseAuth.instance.currentUser!.uid,
                    //     chapterName: widget.chapter.name,
                    //     chapterId: widget.chapter.id!,
                    //     price: widget.chapter.price,
                    //     purchaseDate: DateTime.now(),
                    //     endDate: DateTime.now().add(Duration(days: widget.chapter.duration as int)),
                    //     paymentStatus: "Paid"
                    //   );
                    //       await courseController.addPurchase(purchase);
                    //   Get.snackbar(
                    //     'Success',
                    //     'Chapter Purchases successfully',
                    //     backgroundColor: Colors.green,
                    //     colorText: Colors.white,
                    //   );
                    //     },
                    onPressed: key == null? null : isLoading
                        ? null
                        : () async {
                            var options = {
                              'key': key.key,
                              // replace with your Razorpay key
                              'amount': (widget.chapter.price * 100).toInt(),
                              // in paise
                              'name': 'Course Purchase',
                              'description': widget.chapter.name,
                              'prefill': {
                                'email': userController.user.value!.email,
                              },
                              'external': {
                                'wallets': ['paytm']
                              }
                            };
                            try {
                              _razorpay.open(options);
                            } catch (e) {
                              debugPrint('Error: $e');
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Processing...',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Buy Now',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      'Master advanced concepts and best practices',
      'Build real-world projects from scratch',
      'Get lifetime access to materials',
      'Join our exclusive community of learners',
      'Receive a certificate upon completion',
    ];

    return Column(
      children: features
          .map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
