import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:literary_heaven/data/mock_books.dart';
import 'package:literary_heaven/models/book.dart';
import 'package:literary_heaven/models/comment.dart';
import 'package:literary_heaven/models/user.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get a stream of all books
  Stream<List<Book>> getBooks() {
    return _db.collection('books').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList());
  }

  // Get a single book by ID
  Stream<Book> getBook(String bookId) {
    return _db
        .collection('books')
        .doc(bookId)
        .snapshots()
        .map((snapshot) => Book.fromFirestore(snapshot));
  }

  // Update the status of a book
  Future<void> updateBookStatus(String bookId, BookStatus status) {
    return _db
        .collection('books')
        .doc(bookId)
        .update({'status': status.toString().split('.').last});
  }

  // Toggle the favorite status of a book
  Future<void> toggleFavorite(String bookId, bool isFavorite) {
    return _db.collection('books').doc(bookId).update({'isFavorite': isFavorite});
  }

  // Add a comment to a book
  Future<void> addComment(String bookId, Comment comment) {
    return _db.collection('books').doc(bookId).update({
      'comments': FieldValue.arrayUnion([comment.toMap()])
    });
  }

  // Update the user rating of a book
  Future<void> updateRating(String bookId, double rating) {
    return _db.collection('books').doc(bookId).update({'userRating': rating});
  }

  // Update book details like current page, chapter, and personal note
  Future<void> updateBookDetails(String bookId, int currentPage,
      String currentChapter, String personalNote) {
    return _db.collection('books').doc(bookId).update({
      'currentPage': currentPage,
      'currentChapter': currentChapter,
      'personalNote': personalNote,
    });
  }

  // Create a new user document in Firestore
  Future<void> createUser(User user) {
    return _db.collection('users').doc(user.id).set(user.toMap());
  }

  // Update a user document in Firestore
  Future<void> updateUser(User user) {
    return _db.collection('users').doc(user.id).update(user.toMap());
  }

  // Upload mock books to Firestore if they don't exist
  Future<void> uploadMockBooks() async {
    final booksCollection = _db.collection('books');
    final snapshot = await booksCollection.limit(1).get();

    // If there are already books in the collection, don't upload again
    if (snapshot.docs.isNotEmpty) {
      return;
    }

    WriteBatch batch = _db.batch();

    for (var book in mockBooks) {
      final docRef = booksCollection.doc(book.id);
      batch.set(docRef, book.toMap());
    }

    await batch.commit();
  }
}
