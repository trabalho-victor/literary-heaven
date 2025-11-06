import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String? content;
  final String? mediaUrl;
  final String type; // image, video, text
  final DateTime createdAt;
  final List<String> likes;
  final int commentsCount;

  Post({
    required this.id,
    required this.userId,
    this.content,
    this.mediaUrl,
    required this.type,
    required this.createdAt,
    required this.likes,
    required this.commentsCount,
  });

  factory Post.fromMap(Map<String, dynamic> map, String id) {
    return Post(
      id: id,
      userId: map['userId'] ?? '',
      content: map['content'],
      mediaUrl: map['mediaUrl'],
      type: map['type'] ?? 'text',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      likes: List<String>.from(map['likes'] ?? []),
      commentsCount: map['commentsCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'content': content,
      'mediaUrl': mediaUrl,
      'type': type,
      'createdAt': createdAt,
      'likes': likes,
      'commentsCount': commentsCount,
    };
  }
}
