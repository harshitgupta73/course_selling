import 'package:course_app/models/chapter.dart';

class Purchase {
  final String? id;
  final String userId;
  final String chapterId;
  final String chapterName;
  final double price;
  final DateTime purchaseDate;
  final DateTime endDate;
  final String paymentStatus;

  Purchase({
   this.id,
      required this.userId,
      required this.chapterId,
      required this.chapterName,
      required this.price,
      required this.purchaseDate,
      required this.endDate,
      required this.paymentStatus
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      userId: json['userId'],
      chapterId: json['chapterId'],
      chapterName: json['chapterName'],
      price: (json['price'] as num).toDouble(),
      purchaseDate: DateTime.parse(json['purchaseDate']),
      endDate: DateTime.parse(json['endDate']),
      paymentStatus: json['paymentStatus'] ?? 'Paid',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'chapterId': chapterId,
      'chapterName': chapterName,
      'price': price,
      'purchaseDate': purchaseDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'paymentStatus': paymentStatus,
    };
  }

  bool get isExpired => endDate.isBefore(DateTime.now());

}
