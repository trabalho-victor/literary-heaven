import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:literary_heaven/models/comment.dart';

enum BookStatus { read, reading, wantToRead }

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
  final String personalNote;

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
    this.personalNote = '',
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Book(
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      coverUrl: data['coverUrl'] ?? '',
      synopsis: data['synopsis'] ?? '',
      status: BookStatus.values.firstWhere(
        (e) => e.toString() == 'BookStatus.${data['status']}',
        orElse: () => BookStatus.wantToRead,
      ),
      generalRating: (data['generalRating'] ?? 0.0).toDouble(),
      userRating: (data['userRating'] ?? 0.0).toDouble(),
      comments: (data['comments'] as List<dynamic>?)
              ?.map((comment) => Comment.fromMap(comment))
              .toList() ??
          [],
      currentPage: data['currentPage'] ?? 0,
      currentChapter: data['currentChapter'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
      personalNote: data['personalNote'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'coverUrl': coverUrl,
      'synopsis': synopsis,
      'status': status.toString().split('.').last,
      'generalRating': generalRating,
      'userRating': userRating,
      'comments': comments.map((comment) => comment.toMap()).toList(),
      'currentPage': currentPage,
      'currentChapter': currentChapter,
      'isFavorite': isFavorite,
      'personalNote': personalNote,
    };
  }

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? coverUrl,
    String? synopsis,
    BookStatus? status,
    double? generalRating,
    double? userRating,
    List<Comment>? comments,
    int? currentPage,
    String? currentChapter,
    bool? isFavorite,
    String? personalNote,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverUrl: coverUrl ?? this.coverUrl,
      synopsis: synopsis ?? this.synopsis,
      status: status ?? this.status,
      generalRating: generalRating ?? this.generalRating,
      userRating: userRating ?? this.userRating,
      comments: comments ?? this.comments,
      currentPage: currentPage ?? this.currentPage,
      currentChapter: currentChapter ?? this.currentChapter,
      isFavorite: isFavorite ?? this.isFavorite,
      personalNote: personalNote ?? this.personalNote,
    );
  }
}
