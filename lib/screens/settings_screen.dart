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
              onTap: () => Navigator.pushNamed(context, '/contact'),
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
          height: 300,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2,
            ),
            itemCount: AppThemes.getThemeNames().length,
            itemBuilder: (context, index) {
              final theme = AppThemes.getThemeNames()[index];
              final isSelected = provider.settings.theme == theme;
              return GestureDetector(
                onTap: () {
                  provider.setTheme(theme);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _getThemeColor(theme),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      theme,
                      style: TextStyle(
                        color: _getTextColor(theme),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
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

  Color _getThemeColor(String theme) {
    switch (theme) {
      case 'light':
        return Colors.white;
      case 'dark':
        return Colors.black;
      case 'neon':
        return Colors.black;
      case 'retro':
        return const Color(0xFFFFF8E1);
      case 'minimal':
        return Colors.white;
      default:
        return Colors.grey;
    }
  }

  Color _getTextColor(String theme) {
    switch (theme) {
      case 'light':
        return Colors.black;
      case 'dark':
        return Colors.white;
      case 'neon':
        return Colors.greenAccent;
      case 'retro':
        return Colors.brown;
      case 'minimal':
        return Colors.black;
      default:
        return Colors.black;
    }
  }

  void _contactUs(BuildContext context) {
    // Placeholder for contact functionality
    // Could open email or website
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact feature coming soon!')),
    );
  }
}