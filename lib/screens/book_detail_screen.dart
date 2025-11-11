import 'package:flutter/material.dart';
import 'package:literary_heaven/models/book.dart';
import 'package:literary_heaven/models/comment.dart';
import 'package:literary_heaven/services/firestore_service.dart';
import 'package:literary_heaven/widgets/app_header.dart';
import 'package:literary_heaven/widgets/comment_card.dart';
import 'package:literary_heaven/widgets/footer.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _currentPageController = TextEditingController();
  final TextEditingController _currentChapterController =
      TextEditingController();
  final TextEditingController _personalNoteController = TextEditingController();
  double _currentUserRating = 0.0;

  @override
  void initState() {
    super.initState();
    _currentUserRating = widget.book.userRating;
    _currentPageController.text = widget.book.currentPage.toString();
    _currentChapterController.text = widget.book.currentChapter;
    _personalNoteController.text = widget.book.personalNote;
  }

  @override
  void dispose() {
    _commentController.dispose();
    _currentPageController.dispose();
    _currentChapterController.dispose();
    _personalNoteController.dispose();
    super.dispose();
  }

  void _updateBookStatus(Book book, BookStatus newStatus) {
    _firestoreService.updateBookStatus(book.id, newStatus);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Book status updated to ${newStatus.name}')),
    );
  }

  void _toggleFavorite(Book book) {
    _firestoreService.toggleFavorite(book.id, !book.isFavorite);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          !book.isFavorite ? 'Added to favorites!' : 'Removed from favorites!',
        ),
      ),
    );
  }

  void _submitRatingAndComment(Book book) {
    if (_currentUserRating > 0) {
      _firestoreService.updateRating(book.id, _currentUserRating);
    }
    if (_commentController.text.isNotEmpty) {
      _firestoreService.addComment(
        book.id,
        Comment(text: _commentController.text, isOwn: true),
      );
    }
    _commentController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rating and comment submitted!')),
    );
  }

  void _saveProgressAndNote(Book book) {
    _firestoreService.updateBookDetails(
      book.id,
      int.tryParse(_currentPageController.text) ?? book.currentPage,
      _currentChapterController.text,
      _personalNoteController.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Progress and personal note saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: Text(widget.book.title), showBackButton: true),
      bottomNavigationBar: const AppFooter(),
      backgroundColor: Colors.white,
      body: StreamBuilder<Book>(
        stream: _firestoreService.getBook(widget.book.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Book not found.'));
          }

          final book = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/book_cover_placeholder.jpg',
                      fit: BoxFit.cover,
                      // Basic error handling for image loading
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.book, color: Colors.grey, size: 80),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  book.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.author,
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check),
                      color: book.status == BookStatus.read
                          ? Colors.green
                          : Colors.grey,
                      onPressed: () => _updateBookStatus(book, BookStatus.read),
                      tooltip: 'Mark as Read',
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      color: book.status == BookStatus.wantToRead
                          ? Colors.blue
                          : Colors.grey,
                      onPressed: () =>
                          _updateBookStatus(book, BookStatus.wantToRead),
                      tooltip: 'Mark as Want to Read',
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu_book),
                      color: book.status == BookStatus.reading
                          ? Colors.orange
                          : Colors.grey,
                      onPressed: () =>
                          _updateBookStatus(book, BookStatus.reading),
                      tooltip: 'Mark as Reading',
                    ),
                    IconButton(
                      icon: Icon(
                        book.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      color: book.isFavorite ? Colors.red : Colors.grey,
                      onPressed: () => _toggleFavorite(book),
                      tooltip: book.isFavorite
                          ? 'Remove from Favorites'
                          : 'Add to Favorites',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Synopsis:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.synopsis,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                if (book.generalRating > 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          'General Rating: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '${book.generalRating}/5.0',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                const Text(
                  'Your Rating:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _currentUserRating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentUserRating = (index + 1).toDouble();
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Current Progress:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _currentPageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Page',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _currentChapterController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Chapter',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Personal Note:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _personalNoteController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add your personal note here...',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _saveProgressAndNote(book),
                    child: const Text('Save Progress & Note'),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Add a Comment:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write your comment here...',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _submitRatingAndComment(book),
                    child: const Text('Submit Rating & Comment'),
                  ),
                ),
                const SizedBox(height: 16),
                if (book.comments.isNotEmpty) ...[
                  const Text(
                    'Comments:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...book.comments.map(
                    (comment) => CommentCard(comment: comment),
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
