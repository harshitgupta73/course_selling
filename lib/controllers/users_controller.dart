import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/models/user.dart';
import 'package:course_app/services/users_services.dart';
import 'package:get/get.dart';

import '../models/razorpay_key_model.dart';

class UsersController extends GetxController{
  var users = <User>[].obs;
  var isLoading = false.obs;

  RazorpaykeyModel? key;

  final UsersServices usersServices = UsersServices();


  @override
  void onInit(){
    super.onInit();
    fetchUsers();
    getKey();
  }

  Future<void> fetchUsers() async {
    isLoading.value =  true;
    users.value = await usersServices.getUsers();
    isLoading.value=false;
  }

  Future<void> addRazorpay(RazorpaykeyModel key) async {
    isLoading.value = true;
    final docRef = FirebaseFirestore.instance.collection('razorpay').doc();
    key.id = docRef.id;
    await docRef.set(key.toJson());
    isLoading.value = false;
  }

  Future<void> updateRazorpay(RazorpaykeyModel key) async {
    isLoading.value = true;
    try{
      final docRef = FirebaseFirestore.instance.collection('razorpay').doc(key.id);
      await docRef.update(key.toJson());
    }
    catch(e){
      print("Error updating Razorpay key: $e");
    }
    isLoading.value = false;
  }

  Future<void> getKey() async {
    isLoading.value = true;
    try {
      final snapshot = await FirebaseFirestore.instance.collection('razorpay').get();
      if (snapshot.docs.isNotEmpty) {
        key = RazorpaykeyModel.fromJson(snapshot.docs.first.data());
        key!.id = snapshot.docs.first.id;
      }
    } catch (e) {
      print("Error fetching Razorpay key: $e");
    } finally {
      isLoading.value = false;
    }
  }

}