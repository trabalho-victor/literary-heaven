class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final List<String> favoriteGenres;
  final String? profilePictureUrl;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.favoriteGenres,
    this.profilePictureUrl,
  });

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      favoriteGenres: List<String>.from(map['favoriteGenres'] ?? []),
      profilePictureUrl: map['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'favoriteGenres': favoriteGenres,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
