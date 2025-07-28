// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/subject.dart';

// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String _collection = 'subjects';

//   // Add a new subject
//   Future<void> addSubject(Subject subject) async {
//     try {
//       await _firestore.collection(_collection).add({
//         'name': subject.name,
//         'image': subject.image,
//         'description': subject.description,
//         'category': subject.category,
//       });
//     } catch (e) {
//       print('Error adding subject: $e');
//       rethrow;
//     }
//   }

//   // Get all subjects
//   Stream<List<Subject>> getSubjects() {
//     return _firestore.collection(_collection).snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         Map<String, dynamic> data = doc.data();
//         return Subject(
//           id: int.parse(doc.id),
//           name: data['name'],
//           image: data['image'],
//           description: data['description'],
//           category: data['category'],
//         );
//       }).toList();
//     });
//   }

//   // Get subject by ID
//   Future<Subject?> getSubjectById(String id) async {
//     try {
//       DocumentSnapshot doc =
//           await _firestore.collection(_collection).doc(id).get();
//       if (doc.exists) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         return Subject(
//           id: int.parse(doc.id),
//           name: data['name'],
//           image: data['image'],
//           description: data['description'],
//           category: data['category'],
//         );
//       }
//       return null;
//     } catch (e) {
//       print('Error getting subject: $e');
//       rethrow;
//     }
//   }

//   // Update subject
//   Future<void> updateSubject(String id, Subject subject) async {
//     try {
//       await _firestore.collection(_collection).doc(id).update({
//         'name': subject.name,
//         'image': subject.image,
//         'description': subject.description,
//         'category': subject.category,
//       });
//     } catch (e) {
//       print('Error updating subject: $e');
//       rethrow;
//     }
//   }

//   // Delete subject
//   Future<void> deleteSubject(String id) async {
//     try {
//       await _firestore.collection(_collection).doc(id).delete();
//     } catch (e) {
//       print('Error deleting subject: $e');
//       rethrow;
//     }
//   }
// }
