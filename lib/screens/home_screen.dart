import 'package:flutter/material.dart';
import 'package:literary_heaven/models/book.dart';
import 'package:literary_heaven/services/firestore_service.dart';
import 'package:literary_heaven/widgets/book_category_section.dart';
import 'package:literary_heaven/widgets/app_header.dart';
import 'package:literary_heaven/widgets/footer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      backgroundColor: Colors.white,
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
          // Simulate "Most Read" by taking a distinct subset of books
          final mostRead = books.sublist(0, 15);

          // "Most Evaluated" by sorting by rating in descending order
          final mostEvaluated = List.of(books)
            ..sort((a, b) => b.generalRating.compareTo(a.generalRating));
          final top15MostEvaluated = mostEvaluated.take(15).toList();

          // Simulate "Best Sellers" by taking another distinct subset
          final bestSellers = books.sublist(15, 30);

          // Simulate "Editor's Picks" by taking another distinct subset
          final editorsPicks = books.sublist(30, 45);

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                BookCategorySection(
                  title: 'Most Read of the Week',
                  books: mostRead,
                ),
                BookCategorySection(
                  title: 'Most Evaluated',
                  books: top15MostEvaluated,
                ),
                BookCategorySection(title: 'Best Sellers', books: bestSellers),
                BookCategorySection(
                    title: "Editor's Picks", books: editorsPicks),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
