import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String id;
  final String userId;
  final String mediaUrl;
  final DateTime createdAt;
  final DateTime expiresAt;
  final List<String> viewedBy;

  Story({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    required this.createdAt,
    required this.expiresAt,
    required this.viewedBy,
  });

  factory Story.fromMap(Map<String, dynamic> map, String id) {
    return Story(
      id: id,
      userId: map['userId'] ?? '',
      mediaUrl: map['mediaUrl'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      expiresAt: (map['expiresAt'] as Timestamp).toDate(),
      viewedBy: List<String>.from(map['viewedBy'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'mediaUrl': mediaUrl,
      'createdAt': createdAt,
      'expiresAt': expiresAt,
      'viewedBy': viewedBy,
    };
  }
}
