class Comment {
  final String text;
  final bool isOwn;

  Comment({
    required this.text,
    this.isOwn = true, // Default to true for user's own comments
  });

  // Factory constructor to create a Comment from a map
  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      text: map['text'] as String,
      isOwn: map['isOwn'] as bool,
    );
  }

  // Method to convert a Comment to a map
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isOwn': isOwn,
    };
  }

  Comment copyWith({
    String? text,
    bool? isOwn,
  }) {
    return Comment(
      text: text ?? this.text,
      isOwn: isOwn ?? this.isOwn,
    );
  }
}