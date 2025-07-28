// import 'package:course_app/models/chapter.dart';

// // Add Category class
// class Category {
//   final int id;
//   final String name;
//   final List<Course> courses;

//   Category({
//     required this.id,
//     required this.name,
//     required this.courses,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       name: json['name'],
//       courses: (json['courses'] as List<dynamic>?)
//               ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'courses': courses.map((c) => c.toJson()).toList(),
//     };
//   }
// }

// class Course {
//   final int id;
//   final String name;
//   final double price;
//   final String imageUrl;
//   final double rating;
//   final int students;
//   final String duration;
//   final DateTime expiryDate;
//   final String description;
//   final List<Chapter> chapters;

//   Course({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.imageUrl,
//     required this.rating,
//     required this.students,
//     required this.duration,
//     required this.expiryDate,
//     required this.description,
//     required this.chapters,
//   });

//   factory Course.fromJson(Map<String, dynamic> json) {
//     return Course(
//       id: json['id'],
//       name: json['name'],
//       price: json['price'].toDouble(),
//       imageUrl: json['imageUrl'],
//       rating: json['rating'].toDouble(),
//       students: json['students'],
//       duration: json['duration'],
//       expiryDate: DateTime.parse(json['expiryDate']),
//       description: json['description'],
//       chapters: (json['chapters'] as List<dynamic>?)
//               ?.map((e) => Chapter.fromJson(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'price': price,
//       'imageUrl': imageUrl,
//       'rating': rating,
//       'students': students,
//       'duration': duration,
//       'expiryDate': expiryDate.toIso8601String(),
//       'description': description,
//       'chapters': chapters.map((c) => c.toJson()).toList(),
//     };
//   }
// }

class Subject {
  final String? id;
  final String name;
  final String image;
  final String description;
  late final String category;

  var chapters;

  Subject({
    this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.category,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'category': category,
    };
  }
}