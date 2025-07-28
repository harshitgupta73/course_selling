import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/models/banner.dart';
import 'package:flutter/material.dart';

class BannerServices {
  final collection = FirebaseFirestore.instance.collection("banner");

  Future<void> addBanner(Banners banner) async {
    try {
      await collection.doc(banner.id).set(banner.toJson());
    } catch (e) {
      print("Error adding banner : $e");
      rethrow;
    }
  }

  Future<List<Banners>> getAllBanners() async {
    try {
      final QuerySnapshot querySnapshot = await collection.get();
      final List<Banners> banners = querySnapshot.docs.map((doc) {
        return Banners(imageUrl: doc['imageUrl'],id: doc['id']);
      }).toList();
      return banners;
    } catch (e) {
      print("Error getting banners : $e");
      rethrow;
    }
  }

  Future<void> deleteBanner(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting banner : $e");
      rethrow;
    }
  }
}
