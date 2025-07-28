import 'dart:ffi';

class Chapter {
  final String? id;
  final String name;
  final int duration;
  final String category;
  final String subject;
  final double price;
  final String description;
  final String pdf;
  final double rating;
  final DateTime timestamp;

  Chapter({
     this.id,
    required this.name,
    required this.duration,
    required this.category,
    required this.subject,
    required this.price,
    required this.description,
    required this.pdf,
    required this.rating,
    required this.timestamp,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      category: json['category'],
      subject: json['subject'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      pdf: json['pdf'],
      rating: (json['rating'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'category': category,
      'subject': subject,
      'price': price,
      'description': description,
      'pdf': pdf,
      'rating': rating,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}