import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String message;
  final DateTime createdAt;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.message,
    required this.createdAt,
  });

  factory Contact.fromMap(Map<String, dynamic> map, String id) {
    return Contact(
      id: id,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      message: map['message'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'message': message,
      'createdAt': createdAt,
    };
  }
}
