import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/models/purchase.dart';

class PurchaseServices {
  final CollectionReference _firestore = FirebaseFirestore.instance.collection("purchases");

  Future<void> purchaseCourse(Purchase purchase) async {
    try {
      Purchase purchases = Purchase(
        userId: purchase.userId,
        chapterId: purchase.chapterId,
        chapterName: purchase.chapterName,
        paymentStatus: purchase.paymentStatus,
        purchaseDate: purchase.purchaseDate,
        price: purchase.price,
        endDate: purchase.endDate,
      );
      await _firestore.add(purchases.toJson());
    } catch (e) {
      print('Error purchasing course: $e');
    }
  }

  Future<List<Purchase>> getPurchaseCourse() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .get();
      final List<Purchase> purchases =
          querySnapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Purchase(
              userId: doc['userId'],
              chapterId: data['chapterId'],
              chapterName: data['chapterName'],
              paymentStatus: data['paymentStatus'],
              purchaseDate: DateTime.parse(data['purchaseDate']),
              price: (data['price'] as num).toDouble(),
              endDate: DateTime.parse(data['endDate']),
            );
          }).toList();
      return purchases;
    } catch (e) {
      print('Error purchasing course: $e');
      rethrow;
    }
  }
}
