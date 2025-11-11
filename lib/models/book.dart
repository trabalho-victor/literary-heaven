import 'package:literary_heaven/models/comment.dart';

// Defines the possible statuses for a book in the user's library.
enum BookStatus {
  read,
  reading,
  wantToRead,
}

// Represents a book entity in the application.
class Book {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String synopsis;
  final BookStatus status;
  final double generalRating;
  final double userRating;
  final List<Comment> comments;
  final int currentPage;
  final String currentChapter;
  final bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.synopsis,
    required this.status,
    this.generalRating = 0.0,
    this.userRating = 0.0,
    this.comments = const [],
    this.currentPage = 0,
    this.currentChapter = '',
    this.isFavorite = false,
  });
}
