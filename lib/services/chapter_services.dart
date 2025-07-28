import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/models/subject.dart';
import 'package:course_app/services/storage_services.dart';
import '../models/chapter.dart';

class ChapterService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get chapters for a specific subject
  Future<List<Chapter>> getChapters() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection("chapters").get();
      final List<Chapter> chapters = querySnapshot.docs.map((doc) {
        return Chapter(
          id: doc.id,
          name: doc['name'],
          duration: doc['duration'],
          category: doc['category'],
          subject: doc['subject'],
          price: doc['price'].toDouble(),
          description: doc['description'],
          pdf: doc['pdf'],
          rating: doc['rating'].toDouble(),
          timestamp: DateTime.parse(doc['timestamp']),
        );
      }).toList();
      return chapters;
    } catch (e) {
      print("Error getting categories: $e");
      rethrow;
    }
  }

  // Purchase a chapter
  Future<void> addChapter(Chapter chapter) async {
    try {
      File file = File(chapter.pdf);
      Chapter chapters = Chapter(
          name: chapter.name,
          duration: chapter.duration,
          category: chapter.category,
          subject: chapter.subject,
          price: chapter.price,
          description: chapter.description,
          pdf: chapter.pdf,
          rating: chapter.rating,
          timestamp: chapter.timestamp);
      await _firestore.collection('chapters').add(chapters.toJson());
    } catch (e) {
      print('Error adding chapter: $e');
      rethrow;
    }
  }

  Future<void> updateChapter(String id, Chapter updatedChapter) async {
    try {
      Chapter newUpdatedSubject = Chapter(
          id: id,
          name: updatedChapter.name,
          duration: updatedChapter.duration,
          category: updatedChapter.category,
          subject: updatedChapter.subject,
          price: updatedChapter.price,
          description: updatedChapter.description,
          pdf: updatedChapter.pdf,
          rating: updatedChapter.rating,
          timestamp: updatedChapter.timestamp);
      await _firestore
          .collection("chapters")
          .doc(id)
          .update(newUpdatedSubject.toJson());
    } catch (e) {
      print("Error updating chapter: $e");
      rethrow;
    }
  }

  Future<void> deleteChapter(String id) async {
    try {
      await _firestore.collection("chapters").doc(id).delete();
    } catch (e) {
      print("Error deleting chapter: $e");
      rethrow;
    }
  }
}
