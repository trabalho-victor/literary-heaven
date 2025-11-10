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
  final double rating;
  final List<String> notes;
  final int currentPage;
  final String currentChapter;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.synopsis,
    required this.status,
    this.rating = 0.0,
    this.notes = const [],
    this.currentPage = 0,
    this.currentChapter = '',
  });
}
