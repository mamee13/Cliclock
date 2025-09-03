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
    final themes = AppThemes.getThemeNames();
    final initialPage = themes.indexOf(provider.settings.theme);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Choose Theme',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  controller: PageController(initialPage: initialPage),
                  itemCount: themes.length,
                  itemBuilder: (context, index) {
                    final theme = themes[index];
                    final isSelected = provider.settings.theme == theme;
                    return GestureDetector(
                      onTap: () {
                        provider.setTheme(theme);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: _getThemeColor(theme),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '12:34',
                                style: TextStyle(
                                  color: _getTextColor(theme),
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  shadows: _getThemeShadows(theme),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                theme.toUpperCase(),
                                style: TextStyle(
                                  color: _getTextColor(theme),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 30,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ],
          ),
        ),
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
      case 'gradient':
        return Colors.purple;
      case 'ocean':
        return const Color(0xFF006994);
      case 'sunset':
        return const Color(0xFFFF6B35);
      case 'forest':
        return const Color(0xFF0B6623);
      case 'cosmic':
        return const Color(0xFF0F0F23);
      case 'fire':
        return const Color(0xFFFF4500);
      case 'ice':
        return const Color(0xFF00BFFF);
      case 'desert':
        return const Color(0xFFD2691E);
      case 'galaxy':
        return const Color(0xFF2E1A47);
      case 'aurora':
        return const Color(0xFF0F1419);
      case 'storm':
        return const Color(0xFF1F2937);
      case 'meadow':
        return const Color(0xFF16A34A);
      case 'candy':
        return const Color(0xFFEC4899);
      case 'vintage':
        return const Color(0xFF92400E);
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
      case 'gradient':
        return Colors.white;
      case 'ocean':
        return Colors.white;
      case 'sunset':
        return Colors.white;
      case 'forest':
        return Colors.white;
      case 'cosmic':
        return Colors.white;
      case 'fire':
        return Colors.white;
      case 'ice':
        return Colors.white;
      case 'desert':
        return Colors.white;
      case 'galaxy':
        return Colors.white;
      case 'aurora':
        return Colors.white;
      case 'storm':
        return Colors.white;
      case 'meadow':
        return Colors.white;
      case 'candy':
        return Colors.white;
      case 'vintage':
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  List<Shadow> _getThemeShadows(String theme) {
    switch (theme) {
      case 'neon':
        return [const Shadow(color: Colors.greenAccent, blurRadius: 10)];
      case 'cosmic':
        return [const Shadow(color: Colors.purpleAccent, blurRadius: 10)];
      case 'galaxy':
        return [const Shadow(color: Colors.pinkAccent, blurRadius: 10)];
      case 'aurora':
        return [const Shadow(color: Colors.greenAccent, blurRadius: 10)];
      case 'storm':
        return [const Shadow(color: Colors.blueGrey, blurRadius: 10)];
      default:
        return [];
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