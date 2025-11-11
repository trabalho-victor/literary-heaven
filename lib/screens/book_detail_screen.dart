import 'package:flutter/material.dart';
import 'package:literary_heaven/models/book.dart';
import 'package:literary_heaven/data/mock_books.dart'; // Import mock_books to update status

class BookDetailScreen extends StatefulWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late Book _currentBook;

  @override
  void initState() {
    super.initState();
    _currentBook = widget.book;
  }

  void _updateBookStatus(BookStatus newStatus) {
    setState(() {
      // Find the book in mockBooks and update its status
      final index = mockBooks.indexWhere((b) => b.id == _currentBook.id);
      if (index != -1) {
        mockBooks[index] = Book(
          id: _currentBook.id,
          title: _currentBook.title,
          author: _currentBook.author,
          coverUrl: _currentBook.coverUrl,
          synopsis: _currentBook.synopsis,
          status: newStatus,
          rating: _currentBook.rating,
          notes: _currentBook.notes,
          currentPage: _currentBook.currentPage,
          currentChapter: _currentBook.currentChapter,
          isFavorite: _currentBook.isFavorite,
        );
        _currentBook = mockBooks[index]; // Update local state with the modified book
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Book status updated to ${newStatus.name}')),
    );
  }

  void _toggleFavorite() {
    setState(() {
      final index = mockBooks.indexWhere((b) => b.id == _currentBook.id);
      if (index != -1) {
        mockBooks[index] = Book(
          id: _currentBook.id,
          title: _currentBook.title,
          author: _currentBook.author,
          coverUrl: _currentBook.coverUrl,
          synopsis: _currentBook.synopsis,
          status: _currentBook.status,
          rating: _currentBook.rating,
          notes: _currentBook.notes,
          currentPage: _currentBook.currentPage,
          currentChapter: _currentBook.currentChapter,
          isFavorite: !_currentBook.isFavorite, // Toggle favorite status
        );
        _currentBook = mockBooks[index]; // Update local state with the modified book
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            _currentBook.isFavorite ? 'Added to favorites!' : 'Removed from favorites!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentBook.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  _currentBook.coverUrl,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 250,
                    width: 160,
                    color: Colors.grey[300],
                    child: Icon(Icons.book, size: 80, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _currentBook.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _currentBook.author,
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
                  color: _currentBook.status == BookStatus.read ? Colors.green : Colors.grey,
                  onPressed: () => _updateBookStatus(BookStatus.read),
                  tooltip: 'Mark as Read',
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  color: _currentBook.status == BookStatus.wantToRead ? Colors.blue : Colors.grey,
                  onPressed: () => _updateBookStatus(BookStatus.wantToRead),
                  tooltip: 'Mark as Want to Read',
                ),
                IconButton(
                  icon: const Icon(Icons.menu_book),
                  color: _currentBook.status == BookStatus.reading ? Colors.orange : Colors.grey,
                  onPressed: () => _updateBookStatus(BookStatus.reading),
                  tooltip: 'Mark as Reading',
                ),
                IconButton(
                  icon: Icon(
                    _currentBook.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: _currentBook.isFavorite ? Colors.red : Colors.grey,
                  onPressed: _toggleFavorite,
                  tooltip: _currentBook.isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
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
              _currentBook.synopsis,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            if (_currentBook.rating > 0)
              Text(
                'Rating: ${_currentBook.rating}/5.0',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            if (_currentBook.currentPage > 0 || _currentBook.currentChapter.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Progress: Page ${_currentBook.currentPage}, Chapter ${_currentBook.currentChapter}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
