import 'package:flutter/material.dart';
import 'package:literary_heaven/models/user.dart';
import 'package:literary_heaven/screens/edit_profile_screen.dart';
import 'package:literary_heaven/services/auth_service.dart';
import 'package:literary_heaven/widgets/app_header.dart';
import 'package:literary_heaven/widgets/footer.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    const darkGreen = Color(0xFF4C6B4F);
    const darkRed = Color(0xFFB63C3C);
    const cream = Color(0xFFF5F4EC);
    const darkText = Color(0xFF2E2D26);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: const AppHeader(),
      backgroundColor: Colors.white,
      bottomNavigationBar: const AppFooter(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
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
                    const Text(
                      "Profile",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: darkGreen,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          user.profilePictureUrl ?? "assets/carlos.jpeg",
                          width: 180,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: Text(
                        '${user.firstName} ${user.lastName}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _infoItem("Email:", user.email),
                    _infoItem("Username:", user.username),
                    _infoItem(
                      "Favorite Genre:",
                      user.favoriteGenres.join(', '),
                    ),
                    _infoItem("Books Read:", "120"),
                    _infoItem("Currently Reading:", "Little Red Riding Hood"),
                    _infoItem("Most Evaluated:", "The Hobbit"),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _profileButton(
                          label: "Edit Profile",
                          color: darkGreen,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const EditProfileScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        _profileButton(
                          label: "Exit",
                          color: darkRed,
                          onTap: () {
                            AuthService().signOut();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title ",
            style: const TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onPressed: onTap,
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
