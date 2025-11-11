import 'package:flutter/material.dart';
import 'package:literary_heaven/models/user.dart';
import 'package:literary_heaven/services/auth_service.dart';
import 'package:literary_heaven/data/mock_users.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({super.key, required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _favoriteGenresController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _usernameController = TextEditingController(text: widget.user.username);
    _favoriteGenresController =
        TextEditingController(text: widget.user.favoriteGenres.join(', '));
  }

  void _saveProfile() {
    final updatedUser = {
      'id': widget.user.id,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'email': widget.user.email,
      'username': _usernameController.text,
      'password': 'password123', // In a real app, handle this securely
      'favoriteGenres': _favoriteGenresController.text
          .split(',')
          .map((e) => e.trim())
          .toList(),
      'profilePictureUrl': widget.user.profilePictureUrl,
    };

    final userIndex =
        mockUsersData.indexWhere((user) => user['id'] == widget.user.id);
    if (userIndex != -1) {
      mockUsersData[userIndex] = updatedUser;
    }

    AuthService().currentUser = User.fromMap(updatedUser, updatedUser['id'] as String);

    Navigator.pop(context, true); // Return true to indicate success
  }

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF4C6B4F);
    const cream = Color(0xFFF5F4EC);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: darkGreen,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_firstNameController, 'First Name'),
              const SizedBox(height: 20),
              _buildTextField(_lastNameController, 'Last Name'),
              const SizedBox(height: 20),
              _buildTextField(_usernameController, 'Username'),
              const SizedBox(height: 20),
              _buildTextField(
                  _favoriteGenresController, 'Favorite Genres (comma separated)'),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _saveProfile,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
