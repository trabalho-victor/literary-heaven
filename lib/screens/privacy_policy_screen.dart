import 'package:flutter/material.dart';
import 'package:literary_heaven/widgets/footer.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
            children: const [
              TextSpan(
                text: "Privacy Policy\n\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextSpan(
                text:
                    "Your privacy is important to us. This policy explains how we collect, use, and protect your personal information.\n\n",
              ),
              TextSpan(
                text: "1. Information We Collect\n",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    "We may collect personal information such as name, email address, and browsing activity to improve our services.\n\n",
              ),
              TextSpan(
                text: "2. How We Use Your Information\n",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    "Your data is used to enhance user experience, provide customer support, and send important updates.\n\n",
              ),
              TextSpan(
                text: "3. Data Protection\n",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    "We implement security measures to protect your data from unauthorized access and misuse.\n\n",
              ),
              TextSpan(
                text: "4. Third-Party Sharing\n",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    "We do not sell or share your personal information with third parties without your consent, except when required by law.\n\n",
              ),
              TextSpan(
                text: "5. Policy Updates\n",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    "We reserve the right to update this policy at any time. Continued use of our services implies acceptance of the updated policy.\n",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppFooter(),
    );
  }
}
