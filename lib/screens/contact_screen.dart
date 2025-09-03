import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.displayLarge?.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: orientation == Orientation.portrait
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildContactContent(context),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Get in Touch',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'We\'d love to hear from you! Reach out for support, feedback, or any questions.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: _buildContactItems(context),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  List<Widget> _buildContactContent(BuildContext context) {
    return [
      const Text(
        'Get in Touch',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      const Text(
        'We\'d love to hear from you! Reach out for support, feedback, or any questions.',
        style: TextStyle(fontSize: 16),
      ),
      const SizedBox(height: 40),
      ..._buildContactItems(context),
    ];
  }

  List<Widget> _buildContactItems(BuildContext context) {
    return [
      _buildContactItem(
        context,
        icon: Icons.email,
        title: 'Email',
        subtitle: 'support@cliclock.com',
        onTap: () => _launchEmail(),
      ),
      const SizedBox(height: 20),
      _buildContactItem(
        context,
        icon: Icons.web,
        title: 'Website',
        subtitle: 'www.cliclock.com',
        onTap: () => _launchWebsite(),
      ),
      const SizedBox(height: 20),
      _buildContactItem(
        context,
        icon: Icons.phone,
        title: 'Phone',
        subtitle: '+1 (555) 123-4567',
        onTap: () => _launchPhone(),
      ),
      const SizedBox(height: 20),
      _buildContactItem(
        context,
        icon: Icons.telegram,
        title: 'Telegram',
        subtitle: '@cliclocksupport',
        onTap: () => _launchTelegram(),
      ),
    ];
  }

  Widget _buildContactItem(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7))),
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@cliclock.com',
      queryParameters: {'subject': 'Cliclock Support'},
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchWebsite() async {
    final Uri websiteUri = Uri.parse('https://www.cliclock.com');
    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri);
    }
  }

  void _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+15551234567');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _launchTelegram() async {
    final Uri telegramUri = Uri.parse('https://t.me/cliclocksupport');
    if (await canLaunchUrl(telegramUri)) {
      await launchUrl(telegramUri);
    }
  }
}