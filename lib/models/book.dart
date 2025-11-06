import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String userId;
  final String title;
  final String author;
  final String genre;
  final double? rating;
  final String? comment;
  final DateTime createdAt;

  Book({
    required this.id,
    required this.userId,
    required this.title,
    required this.author,
    required this.genre,
    this.rating,
    this.comment,
    required this.createdAt,
  });

  factory Book.fromMap(Map<String, dynamic> map, String id) {
    return Book(
      id: id,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      genre: map['genre'] ?? '',
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      comment: map['comment'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'author': author,
      'genre': genre,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
    };
  }
}
