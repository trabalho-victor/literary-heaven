import 'package:flutter/material.dart';
import 'package:literary_heaven/models/book.dart';
import 'package:literary_heaven/services/firestore_service.dart';
import 'package:literary_heaven/widgets/book_card.dart';
import 'package:literary_heaven/widgets/app_header.dart';
import 'package:literary_heaven/widgets/footer.dart';
import 'package:literary_heaven/screens/book_detail_screen.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirestoreService _firestoreService = FirestoreService();

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

  void _navigateToDetail(Book book) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
    );
  }

  void _toggleFavorite(Book book) {
    _firestoreService.toggleFavorite(book.id, !book.isFavorite);
  }

  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder<List<Book>>(
        stream: _firestoreService.getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No books found.'));
          }

          final books = snapshot.data!;
          final List<Book> readingBooks =
              books.where((book) => book.status == BookStatus.reading).toList();
          final List<Book> wantToReadBooks = books
              .where((book) => book.status == BookStatus.wantToRead)
              .toList();
          final List<Book> readBooks =
              books.where((book) => book.status == BookStatus.read).toList();
          final List<Book> favoritedBooks =
              books.where((book) => book.isFavorite).toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildBookGrid(readingBooks),
              _buildBookGrid(wantToReadBooks),
              _buildBookGrid(readBooks),
              _buildBookGrid(favoritedBooks),
            ],
          );
        },
      ),
    );
  }

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
        final book = books[index];

        return GestureDetector(
          onTap: () => _navigateToDetail(book),
          child: BookCard(
            book: book,
            onFavoritePressed: () => _toggleFavorite(book),
          ),
        );
      },
    );
  }
}
