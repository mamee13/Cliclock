import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
import '../themes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
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
        child: ListView(
          children: [
            _buildSettingCard(
              context,
              icon: Icons.access_time,
              title: 'Show Seconds',
              subtitle: 'Display seconds in the time',
              trailing: Switch(
                value: settingsProvider.settings.showSeconds,
                onChanged: (value) => settingsProvider.toggleShowSeconds(),
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingCard(
              context,
              icon: Icons.calendar_today,
              title: 'Show Date',
              subtitle: 'Display current date below time',
              trailing: Switch(
                value: settingsProvider.settings.showDate,
                onChanged: (value) => settingsProvider.toggleShowDate(),
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingCard(
              context,
              icon: Icons.palette,
              title: 'Theme',
              subtitle: settingsProvider.settings.theme,
              onTap: () => _showThemePicker(context, settingsProvider),
            ),
            const SizedBox(height: 16),
            _buildSettingCard(
              context,
              icon: Icons.contact_mail,
              title: 'Contact Us',
              subtitle: 'Get in touch with us',
              onTap: () => _contactUs(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7))),
        trailing: trailing,
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  void _showThemePicker(BuildContext context, SettingsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        content: SizedBox(
          width: double.maxFinite,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: AppThemes.getThemeNames().map((theme) => ElevatedButton(
              onPressed: () {
                provider.setTheme(theme);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: provider.settings.theme == theme ? Theme.of(context).primaryColor : null,
                foregroundColor: provider.settings.theme == theme ? Colors.white : null,
              ),
              child: Text(theme),
            )).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _contactUs(BuildContext context) {
    // Placeholder for contact functionality
    // Could open email or website
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact feature coming soon!')),
    );
  }
}