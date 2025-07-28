import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/models/user.dart';

class UsersServices{
  final userCollection = FirebaseFirestore.instance.collection("users");

  Future<List<User>> getUsers() async{
    try{
      final QuerySnapshot querySnapshot =
      await userCollection.get();
      final List<User> users = querySnapshot.docs.map((doc) {
        return User(
          id: doc['id'],
          name: doc['name'],
          dateOfBirth: DateTime.parse(doc['dateOfBirth']),
          className: doc['className'],
          address: doc['address'],
          email: doc['email'],
          phone: doc['phone'],
          enrolledCourses: [], completedCourses: [],
        );
      }).toList();
      return users;
    }catch(e){
      print("Error fetching users: $e");
      rethrow;
    }
  }



}