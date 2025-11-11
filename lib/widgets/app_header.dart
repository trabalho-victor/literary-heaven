import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:literary_heaven/models/user.dart';
import 'package:literary_heaven/screens/home_screen.dart';
import 'package:literary_heaven/screens/my_books_screen.dart';
import 'package:literary_heaven/screens/profile.dart';
import 'package:literary_heaven/services/auth_service.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  final bool showBackButton;
  final Widget? title;

  const AppHeader({
    super.key,
    this.bottom,
    this.showBackButton = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final User? currentUser = AuthService().currentUser;

    return AppBar(
      backgroundColor: const Color(0xFFF5F4EC),
      elevation: 1,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF2D5016)),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title:
          title ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset("assets/logo.svg", height: 32)],
          ),
      centerTitle: true,
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.menu, color: Color(0xFF2D5016)),
          onSelected: (String result) {
            switch (result) {
              case 'home':
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
                break;
              case 'profile':
                if (currentUser != null) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(user: currentUser),
                    ),
                    (route) => false,
                  );
                }
                break;
              case 'my_books':
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyBooksScreen(),
                  ),
                  (route) => false,
                );
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(value: 'home', child: Text('Home')),
            const PopupMenuItem<String>(
              value: 'my_books',
              child: Text('My Books'),
            ),
            const PopupMenuItem<String>(
              value: 'profile',
              child: Text('Profile'),
            ),
          ],
        ),
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
