import 'package:flutter/material.dart';
import 'package:literary_heaven/data/mock_books.dart';
import 'package:literary_heaven/widgets/book_category_section.dart';
import 'package:literary_heaven/widgets/app_header.dart';
import 'package:literary_heaven/widgets/footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate "Most Read" by taking a distinct subset of books
    final mostRead = mockBooks.sublist(0, 15);

    // "Most Evaluated" by sorting by rating in descending order
    final mostEvaluated = List.of(mockBooks)
      ..sort((a, b) => b.generalRating.compareTo(a.generalRating));
    final top15MostEvaluated = mostEvaluated.take(15).toList();

    // Simulate "Best Sellers" by taking another distinct subset
    final bestSellers = mockBooks.sublist(15, 30);

    // Simulate "Editor's Picks" by taking another distinct subset
    final editorsPicks = mockBooks.sublist(30, 45);

    return Scaffold(
      appBar: const AppHeader(),
      backgroundColor: Colors.white,
      bottomNavigationBar: const AppFooter(),
      body: SingleChildScrollView(
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
            BookCategorySection(title: "Editor's Picks", books: editorsPicks),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
