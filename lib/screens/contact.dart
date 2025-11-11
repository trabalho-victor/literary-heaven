import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool acceptTerms = false;
  bool stayUpToDate = false;

  @override
  Widget build(BuildContext context) {
    const cream = Color(0xFFF5F4EC);
    const darkGreen = Color(0xFF2D5016);
    const cardBg = Color(0xFFEBEAE0);
    const inputBg = Colors.white;

    return Scaffold(
      backgroundColor: cream,
      body: Column(
        children: [
          _buildCustomHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Contact Us',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: darkGreen,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildTextField(label: 'Name', fillColor: inputBg),
                      const SizedBox(height: 12),
                      _buildTextField(label: 'Last name', fillColor: inputBg),
                      const SizedBox(height: 12),
                      _buildTextField(label: 'Email', fillColor: inputBg),
                      const SizedBox(height: 12),
                      _buildTextField(
                        label: 'Write what you think...',
                        fillColor: inputBg,
                        maxLines: 6,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: Checkbox(
                              value: acceptTerms,
                              onChanged: (value) {
                                setState(() {
                                  acceptTerms = value ?? false;
                                });
                              },
                              activeColor: darkGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              side: BorderSide(
                                color: darkGreen.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Accept the Terms of Use and Privacy Policy',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: darkGreen,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: Checkbox(
                              value: stayUpToDate,
                              onChanged: (value) {
                                setState(() {
                                  stayUpToDate = value ?? false;
                                });
                              },
                              activeColor: darkGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              side: BorderSide(
                                color: darkGreen.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Stay up to date with the latest news',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: darkGreen,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!acceptTerms) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please accept the Terms of Use and Privacy Policy',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Message sent successfully!'),
                                backgroundColor: darkGreen,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkGreen,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Send it',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    const cream = Color(0xFFF5F4EC);
    const darkGreen = Color(0xFF2D5016);

    return SafeArea(
      bottom: false,
      child: Container(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: cream,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: darkGreen, size: 24),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: 'Back to Home',
              ),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/logo.svg", height: 24),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
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
              _buildFooterLink('Privacy Policy', () {}),
              const SizedBox(width: 20),
              _buildFooterLink('Contact', () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    const darkGreen = Color(0xFF2D5016);

    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
          color: darkGreen,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Color fillColor,
    int maxLines = 1,
  }) {
    const darkGreen = Color(0xFF2D5016);

    return TextField(
      maxLines: maxLines,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        color: darkGreen,
      ),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: darkGreen.withOpacity(0.4),
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkGreen.withOpacity(0.3), width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: maxLines > 1 ? 16 : 14,
        ),
      ),
    );
  }
}
