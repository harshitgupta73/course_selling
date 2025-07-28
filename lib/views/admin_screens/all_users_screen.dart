import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/controllers/users_controller.dart';
import 'package:course_app/models/user.dart';
import 'package:course_app/views/admin_screens/user_purchase_screen.dart';
import 'package:course_app/views/purchase_courses_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUsersScreen extends StatelessWidget {
  AllUsersScreen({super.key});

  final UsersController usersController = Get.put(UsersController());
  final CourseController courseController = Get.find<CourseController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: (){
          Get.back();
          courseController.calculatePrice(null);
          return Future.value(false);
        },
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: usersController.users.length,
              itemBuilder: (context, index) {
                final user = usersController.users[index];
        
                return _buildPurchasedSubjectCard(user);
              },
            )),
      ),
    );
  }

  Widget _buildPurchasedSubjectCard(User user) {
    final purchases = courseController.purchases.where((p) => p.userId == user.id).toList();
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Get.to(() => UserPurchaseScreen(user)),
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
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const SizedBox(width: 18),

              // Course Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey[900],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          user.email,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue),
                        ),

                        const SizedBox(
                          width: 10,
                        )
                        // if (isCompleted)
                        //   Icon(Icons.verified_rounded,
                        //       color: Colors.green, size: 22),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.phone,
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
                            user.dateOfBirth.toLocal().toString().split(' ')[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.address,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          "Purchases : ${purchases.length}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 10,)
                      ],
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
