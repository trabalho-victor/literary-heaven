import 'package:flutter/material.dart';
import 'package:literary_heaven/data/mock_books.dart';
import 'package:literary_heaven/models/book.dart';
import 'package:literary_heaven/widgets/book_card.dart';
import 'package:literary_heaven/widgets/app_header.dart';
import 'package:literary_heaven/widgets/footer.dart';

// Main screen that displays the user's book collections.
class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtered lists of books based on their status and favorite state.
    // These are re-filtered each time the build method is called to reflect changes.
    final List<Book> readingBooks =
        mockBooks.where((book) => book.status == BookStatus.reading).toList();
    final List<Book> wantToReadBooks =
        mockBooks.where((book) => book.status == BookStatus.wantToRead).toList();
    final List<Book> readBooks =
        mockBooks.where((book) => book.status == BookStatus.read).toList();
    final List<Book> favoritedBooks =
        mockBooks.where((book) => book.isFavorite).toList();

    return Scaffold(
      appBar: AppHeader(
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Reading'),
            Tab(text: 'Want to Read'),
            Tab(text: 'Read'),
            Tab(text: 'Favorites'),
          ],
        ),
      ),
      bottomNavigationBar: const AppFooter(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookGrid(readingBooks),
          _buildBookGrid(wantToReadBooks),
          _buildBookGrid(readBooks),
          _buildBookGrid(favoritedBooks),
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