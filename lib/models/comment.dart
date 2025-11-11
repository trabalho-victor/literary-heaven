class Comment {
  final String text;
  final bool isOwn;

  Comment({
    required this.text,
    this.isOwn = true, // Default to true for user's own comments
  });

  // Factory constructor to create a Comment from a JSON map
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      text: json['text'] as String,
      isOwn: json['isOwn'] as bool,
    );
  }

  // Method to convert a Comment to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isOwn': isOwn,
    };
  }
}