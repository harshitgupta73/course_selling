import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:get/get.dart';
import '../models/user.dart';
import '../models/user.dart' as UserModel;

class UserController extends GetxController {
  var user = Rxn<User>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  void loadUser() async {
    isLoading.value = true;
    user.value=await fetchUserData();
    isLoading.value = false;
  }

  Future<User?> fetchUserData() async {
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

  void logout() {
    user.value = null;
    // Add any additional logout logic here, such as clearing tokens or storage
  }

  // void updateUser(User updatedUser) {
  //   user.value = updatedUser;
  //   // In real app, save to API/storage
  // }

  // Example for UserController
  void updateUser({
    String? name,
    String? phone,
    String? address,
    required String email,
    required DateTime dateOfBirth,
    required String className,
  }) {
    final currentUser = user.value;
    if (currentUser != null) {
      user.value = currentUser.copyWith(
        name: name ?? currentUser.name,
        phone: phone ?? currentUser.phone,
        address: address ?? currentUser.address,
        email: email,
        dateOfBirth: dateOfBirth,
        className: className,
      );
    }
  }
}
