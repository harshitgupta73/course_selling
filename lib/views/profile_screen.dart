import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/models/user.dart' as UserModel;
import 'package:course_app/views/login_screen.dart';
import 'package:course_app/views/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/user_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserController userController = Get.find();

  // Add this to your MainScreen widget
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginScreen());
  }

  Future<void> _refreshData() async {
    setState(() {});
  }

  Future<UserModel.User?> fetchUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return null;

      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!docSnapshot.exists) return null;

      return UserModel.User.fromJson(
          docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6FB),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.blue.shade800,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_rounded, size: 26),
            onPressed: () => _showEditProfile(context),
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: Colors.blue.shade700,
        backgroundColor: Colors.white,
        strokeWidth: 3,
        displacement: 40,
        child: FutureBuilder<UserModel.User?>(
            future: fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error loading profile',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }

              final user = snapshot.data;
              if (user == null) {
                return Center(
                  child: Text('No profile data found'),
                );
              }
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Column(
                  children: [
                    // Profile Header
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade400, Colors.blue.shade700],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade100,
                            blurRadius: 18,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 52,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person_rounded,
                              size: 70,
                              color: Colors.blue.shade600,
                            ),
                          ),
                          SizedBox(height: 18),
                          Text(
                            user.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 6),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              user.email,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28),

                    // User Details
                    _buildDetailCard('Personal Information', [
                      _buildDetailRow('Name', user.name, Icons.person_rounded),
                      _buildDetailRow(
                        'Date of Birth',
                        DateFormat('MMM dd, yyyy').format(user.dateOfBirth),
                        Icons.cake_rounded,
                      ),
                      _buildDetailRow(
                          'Class', user.className, Icons.school_rounded),
                      _buildDetailRow('Phone', user.phone, Icons.phone_rounded),
                    ]),
                    SizedBox(height: 18),

                    _buildDetailCard('Address', [
                      _buildDetailRow(
                          'Address', user.address, Icons.location_on_rounded),
                    ]),
                    SizedBox(height: 18),

                    // Course Statistics
                    _buildDetailCard('Course Statistics', [
                      _buildDetailRow(
                        'Enrolled Courses',
                        user.enrolledCourses.length.toString(),
                        Icons.book_rounded,
                      ),
                      _buildDetailRow(
                        'Completed Courses',
                        user.completedCourses.length.toString(),
                        Icons.check_circle_rounded,
                      ),
                      _buildDetailRow(
                        'Completion Rate',
                        user.enrolledCourses.isNotEmpty
                            ? '${((user.completedCourses.length / user.enrolledCourses.length) * 100).toStringAsFixed(1)}%'
                            : '0%',
                        Icons.trending_up_rounded,
                      ),
                    ]),
                    SizedBox(height: 24),

                    // ...existing code...

                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: Colors.red.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          letterSpacing: 0.5,
                        ),
                      ),
                      icon: Icon(
                        Icons.logout_rounded,
                        size: 26,
                        color: Colors.white,
                      ),
                      label: Text('Logout'),
                      onPressed: () {
                        signOut();
                      },
                    ),
                    // ...existing code...
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _buildDetailCard(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      shadowColor: Colors.blue.shade100,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
                letterSpacing: 0.3,
              ),
            ),
            SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(7),
            child: Icon(icon, color: Colors.blue.shade400, size: 22),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[900],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfile(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw 'User not authenticated';

      final userData = await fetchUserData();
      if (userData == null) throw 'User data not found';

      final nameController = TextEditingController(text: userData.name);
      final phoneController = TextEditingController(text: userData.phone);
      final addressController = TextEditingController(text: userData.address);
      final classController = TextEditingController(text: userData.className);
      DateTime selectedDate = userData.dateOfBirth;

      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    SizedBox(height: 24),
                    _modernTextField(
                      controller: nameController,
                      label: 'Name',
                      icon: Icons.person_rounded,
                    ),
                    SizedBox(height: 16),
                    _buildDatePickerField(
                      selectedDate: selectedDate,
                      onDateSelected: (date) {
                        setState(() => selectedDate = date);
                      },
                    ),
                    SizedBox(height: 16),
                    _modernTextField(
                      controller: phoneController,
                      label: 'Phone',
                      icon: Icons.phone_rounded,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16),
                    _modernTextField(
                      controller: classController,
                      label: 'Class',
                      icon: Icons.school_rounded,
                    ),
                    SizedBox(height: 16),
                    _modernTextField(
                      controller: addressController,
                      label: 'Address',
                      icon: Icons.location_on_rounded,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () => _updateProfile(
                            context,
                            currentUser.uid,
                            nameController.text,
                            phoneController.text,
                            addressController.text,
                            classController.text,
                            selectedDate,
                          ),
                          child: Text('Save',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _updateProfile(
    BuildContext context,
    String uid,
    String name,
    String phone,
    String address,
    String className,
    DateTime dateOfBirth,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': name,
        'phone': phone,
        'address': address,
        'className': className,
        'dateOfBirth': dateOfBirth.toIso8601String(),
      });

      Navigator.pop(context);
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Widget _buildDatePickerField({
    required DateTime selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: Get.context!,
          initialDate: selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.calendar_today, color: Colors.blue.shade400),
          labelText: 'Date of Birth',
          labelStyle: TextStyle(color: Colors.blue.shade700),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade100),
          ),
        ),
        child: Text(
          DateFormat('MMM dd, yyyy').format(selectedDate),
          style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _modernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue.shade400),
        labelText: label,
        labelStyle:
            TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w500),
        filled: true,
        fillColor: Colors.blue.shade50.withOpacity(0.25),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
    );
  }
}
