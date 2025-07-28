import 'package:course_app/controllers/users_controller.dart';
import 'package:course_app/views/admin_screens/admin_dashboard.dart';
import 'package:course_app/views/admin_screens/category_management_screen.dart';
import 'package:course_app/views/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/course_controller.dart';
import 'controllers/user_controller.dart';
import 'views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase already initialized: $e");
  }

  Get.put(CourseController());
  Get.put(UserController());
  Get.put(UsersController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
