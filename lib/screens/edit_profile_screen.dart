import 'package:flutter/material.dart';
import 'package:literary_heaven/models/user.dart';
import 'package:literary_heaven/services/firestore_service.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _favoriteGenresController;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<User?>(context, listen: false);
    _firstNameController = TextEditingController(text: user?.firstName ?? '');
    _lastNameController = TextEditingController(text: user?.lastName ?? '');
    _usernameController = TextEditingController(text: user?.username ?? '');
    _favoriteGenresController = TextEditingController(
      text: user?.favoriteGenres.join(', ') ?? '',
    );
  }

  void _saveProfile() {
    final user = Provider.of<User?>(context, listen: false);
    if (user == null) return;

    final updatedUser = User(
      id: user.id,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: user.email,
      username: _usernameController.text,
      favoriteGenres: _favoriteGenresController.text
          .split(',')
          .map((e) => e.trim())
          .toList(),
      profilePictureUrl: user.profilePictureUrl,
    );

    _firestoreService.updateUser(updatedUser);

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
                _favoriteGenresController,
                'Favorite Genres (comma separated)',
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
