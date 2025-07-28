import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/subject.dart';

class SubjectServices {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSubject(Subject subject) async {
    try {
      await _firestore.collection("subjects").add({
        'name': subject.name,
        'description': subject.description,
        'category': subject.category,
        'image': subject.image
      });
    } catch (e) {
      print("Error adding subject: $e");
      rethrow;
    }
  }

  Future<List<Subject>> getAllSubjects() async {
    try {
      final QuerySnapshot querySnapshot =
      await _firestore.collection("subjects").get();
      final List<Subject> subjects = querySnapshot.docs.map((doc) {
        return Subject(
          id: doc.id,
          name: doc['name'],
          description: doc['description'],
          category: doc['category'],
          image: doc['image'],
        );
      }).toList();
      return subjects;
    } catch (e) {
      print("Error getting categories: $e");
      rethrow;
    }
  }

  Future<void> updateSubject(String id, Subject updatedSubject) async {
    try {
     Subject newUpdatedSubject =Subject(
       id: id,
         name: updatedSubject.name,
         image: updatedSubject.image,
         description: updatedSubject.description,
         category: updatedSubject.category);
      await _firestore.collection("subjects").doc(id).update(newUpdatedSubject.toJson());
    } catch (e) {
      print("Error updating subject: $e");
      rethrow;
    }
  }

  Future<void> deleteSubject(String id) async {
    try {
      await _firestore.collection("subjects").doc(id).delete();
    } catch (e) {
      print("Error deleting subject: $e");
      rethrow;
    }
  }
}