import 'package:flutter/material.dart';
import 'package:literary_heaven/data/mock_books.dart';
import 'package:literary_heaven/widgets/book_category_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Slicing the mock data for different categories
    final mostRead = mockBooks.sublist(0, 3);
    final mostEvaluated = mockBooks.sublist(3, 6);
    final bestSellers = mockBooks.reversed.toList().sublist(0, 3);
    final editorsPicks = mockBooks.reversed.toList().sublist(3, 6);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Literary Heaven'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Placeholder for menu action
          },
        ),
      ),
      backgroundColor: Colors.white,
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
              books: mostEvaluated,
            ),
            BookCategorySection(
              title: 'Best Sellers',
              books: bestSellers,
            ),
            BookCategorySection(
              title: "Editor's Picks",
              books: editorsPicks,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
