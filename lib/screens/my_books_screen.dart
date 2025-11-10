import 'package:flutter/material.dart';
import 'package:literary_heaven/data/mock_books.dart';
import 'package:literary_heaven/models/book.dart';
import 'package:literary_heaven/widgets/book_card.dart';

// Main screen that displays the user's book collections.
class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Filtered lists of books based on their status.
  final List<Book> _readingBooks =
      mockBooks.where((book) => book.status == BookStatus.reading).toList();
  final List<Book> _wantToReadBooks =
      mockBooks.where((book) => book.status == BookStatus.wantToRead).toList();
  final List<Book> _readBooks =
      mockBooks.where((book) => book.status == BookStatus.read).toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
        backgroundColor: Colors.black87,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Reading'),
            Tab(text: 'Want to Read'),
            Tab(text: 'Read'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookGrid(_readingBooks),
          _buildBookGrid(_wantToReadBooks),
          _buildBookGrid(_readBooks),
        ],
      ),
    );
  }

  // Helper widget to build the grid of books for each tab.
  Widget _buildBookGrid(List<Book> books) {
    if (books.isEmpty) {
      return const Center(
        child: Text(
          'No books in this shelf yet.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return BookCard(book: books[index]);
      },
    );
  }
}