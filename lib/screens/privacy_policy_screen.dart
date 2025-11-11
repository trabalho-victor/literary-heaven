import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          """
Privacy Policy

Your privacy is important to us. This policy explains how we collect, use, and protect your personal information.

1. Information We Collect

We may collect personal information such as name, email address, and browsing activity to improve our services.

2. How We Use Your Information

Your data is used to enhance user experience, provide customer support, and send important updates.

3. Data Protection

We implement security measures to protect your data from unauthorized access and misuse.

4. Third-Party Sharing

We do not sell or share your personal information with third parties without your consent, except when required by law.

5. Policy Updates

We reserve the right to update this policy at any time. Continued use of our services implies acceptance of the updated policy.
          """,
        ),
      ),
    );
  }
}