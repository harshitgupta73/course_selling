import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/models/category.dart';

class CategoryServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCategory(Category category) async {
    try {
      await _firestore.collection("categories").add({
        'name': category.name,
        'image': category.image,
      });
    } catch (e) {
      print("Error adding category: $e");
      rethrow;
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection("categories").get();
      final List<Category> categories = querySnapshot.docs.map((doc) {
        return Category(
          id: doc.id,
          name: doc['name'],
          image: doc['image'],
        );
      }).toList();
      return categories;
    } catch (e) {
      print("Error getting categories: $e");
      rethrow;
    }
  }

  Future<void> updateCategory(String id, String newName, String? newImage) async {
    try {
      await _firestore.collection("categories").doc(id).set({
        'name': newName,
        'image': newImage,
      });
    } catch (e) {
      print("Error updating category: $e");
      rethrow;
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _firestore.collection("categories").doc(categoryId).delete();
    } catch (e) {
      print("Error deleting category: $e");
      rethrow;
    }
  }
}
