import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProTipsPage extends StatefulWidget {
  const ProTipsPage({Key? key}) : super(key: key);

  @override
  State<ProTipsPage> createState() => _ProTipsPageState();
}

class _ProTipsPageState extends State<ProTipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Use Trusted Networks',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Avoid using the application on public or unsecured Wi-Fi networks. These networks can be a hotbed for cyber attacks.',
          ),
          Text(
            'Update Regularly',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Keep the application updated to the latest version. Updates often include critical security patches.',
          ),Text(
            'Secret Key Sharing',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Share secret keys through secure and trusted communication channels only, and never through the chat application itself or any public forum.',
          ),Text(
            'Two-Factor Authentication',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Enable two-factor authentication for your Google account linked with the application. This adds an additional layer of security to your account.',
          ),Text(
            'Password Security',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Do not share your Google account password with anyone. Use a unique, complex password and consider using a password manager.',
          ),Text(
            'Suspicious Activity',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Be aware of any unusual activity in your account. If you notice something suspicious, change your password immediately and report it.',
          ),Text(
            'Backup and Recovery',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Regularly back up your important conversations to a secure location. This helps you restore your data in case of accidental deletion or loss.',
          ),Text(
            'Personal Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Avoid sharing sensitive personal information over chats. Even though the app encrypts all messages, its best to limit the amount of sensitive information you share online.',
          ),
          Text(
            'Encryption Awareness',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ' Understand that while the app uses encryption for security, no system is entirely immune to security risks. Always exercise caution.',
          ),Text(
            'Logout from Other Devices:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Make sure to logout from the app when using shared devices to prevent unauthorized access.',
          ),
        ],
      ),
    );
  }
}
