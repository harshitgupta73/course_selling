class User {
  final String? id;
  final String name;
  final DateTime dateOfBirth;
  final String className;
  final String address;
  final String email;
  final String phone;
  final List<int> enrolledCourses;
  final List<int> completedCourses;

  User({
    this.id,
    required this.name,
    required this.dateOfBirth,
    required this.className,
    required this.address,
    required this.email,
    required this.phone,
    required this.enrolledCourses,
    required this.completedCourses,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      className: json['className'],
      address: json['address'],
      email: json['email'],
      phone: json['phone'],
      enrolledCourses: List<int>.from(json['enrolledCourses']),
      completedCourses: List<int>.from(json['completedCourses']),
    );
  }

  // ...existing code...
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name': name,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'className': className,
      'address': address,
      'email': email,
      'phone': phone,
      'enrolledCourses': enrolledCourses,
      'completedCourses': completedCourses,
    };
  }

  User copyWith({
    String? id,
    String? name,
    DateTime? dateOfBirth,
    String? className,
    String? address,
    String? email,
    String? phone,
    List<int>? enrolledCourses,
    List<int>? completedCourses,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      className: className ?? this.className,
      address: address ?? this.address,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      completedCourses: completedCourses ?? this.completedCourses,
    );
  }
// ...existing code...
}
