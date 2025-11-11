import 'package:flutter/material.dart';
import 'package:literary_heaven/models/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: comment.isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: comment.isOwn ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.isOwn ? 'You' : 'Other User',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: comment.isOwn ? Colors.blue[800] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              comment.text,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}