import 'package:literary_heaven/models/user.dart';

// This is a simplified representation for a demo.
// In a real app, you would NOT store passwords in plaintext.
final List<Map<String, dynamic>> mockUsersData = [
  {
    'id': '1',
    'firstName': 'Carlos',
    'lastName': 'Fernandes',
    'email': 'carlos@example.com',
    'username': 'carlos_fernandes',
    'password': 'password123',
    'favoriteGenres': ['Fantasy', 'Mystery', 'Science Fiction'],
    'profilePictureUrl': 'assets/carlos.jpeg',
  },
  {
    'id': '2',
    'firstName': 'Lobo',
    'lastName': 'Mau',
    'email': 'lobo@mau.com',
    'password': 'password123',
    'favoriteGenres': ['Fantasy', 'Horror'],
    'profilePictureUrl': 'assets/carlos.jpeg',
  },
];

// A list of User models without the password.
final List<User> mockUsers = mockUsersData.map((userData) {
  return User.fromMap(userData, userData['id']);
}).toList();
