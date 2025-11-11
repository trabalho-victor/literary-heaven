import 'package:flutter/material.dart';
import 'package:literary_heaven/models/book.dart';
import 'package:literary_heaven/screens/book_detail_screen.dart';

// A small, reusable widget that displays a book cover image with rounded borders.
class BookCoverItem extends StatelessWidget {
  final Book book;

  const BookCoverItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
        );
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/book_cover_placeholder.jpg',
            fit: BoxFit.cover,
            // Basic error handling for image loading
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.book, color: Colors.grey, size: 40),
              );
            },
          ),
        ),
      ),
    );
  }
}
