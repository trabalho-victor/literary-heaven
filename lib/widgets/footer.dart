import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    const cream = Color(0xFFF5F4EC);
    const darkGreen = Color(0xFF2D5016);

    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: cream,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '© 2025 Literary Heaven',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: darkGreen,
            ),
          ),
          Row(
            children: [
              _footerTextLink(text: 'Privacy Policy', onTap: () {}),
              const SizedBox(width: 20),
              _footerTextLink(
                text: 'Contact',
                onTap: () => Navigator.pushNamed(context, '/contact'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerTextLink({required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
          color: Color(0xFF2D5016),
        ),
      ),
    );
  }
}
