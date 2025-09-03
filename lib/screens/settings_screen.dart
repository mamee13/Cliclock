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
        title: Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: _getAppBarTextColor(context))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 28, color: _getAppBarTextColor(context)),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 4,
        backgroundColor: _getAppBarBackgroundColor(context),
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: Stack(
        children: [
          // Background gradients matching clock screen
          if (settingsProvider.settings.theme == 'neon')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Color(0xFF0D0D0D)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'gradient')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Colors.pink, Colors.orange],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'ocean')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF006994), Color(0xFF00D4FF)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'sunset')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFF6B35), Color(0xFFF7931E), Color(0xFFFFDC00)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'forest')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0B6623), Color(0xFF228B22), Color(0xFF90EE90)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'cosmic')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0F0F23), Color(0xFF1a1a2e), Color(0xFF16213e)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'fire')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFF4500), Color(0xFFFF6347), Color(0xFFFFD700)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'ice')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF00BFFF), Color(0xFF87CEEB), Color(0xFFE0FFFF)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'desert')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFD2691E), Color(0xFFF4A460), Color(0xFFFFDAB9)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'galaxy')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2E1A47), Color(0xFF8B5CF6), Color(0xFFEC4899)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'aurora')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0F1419), Color(0xFF1E3A8A), Color(0xFF06B6D4)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'storm')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1F2937), Color(0xFF374151), Color(0xFF6B7280)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'meadow')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF16A34A), Color(0xFF22C55E), Color(0xFF86EFAC)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'candy')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFEC4899), Color(0xFFF97316), Color(0xFFF59E0B)],
                ),
              ),
            )
          else if (settingsProvider.settings.theme == 'vintage')
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF92400E), Color(0xFFD97706), Color(0xFFFCD34D)],
                ),
              ),
            )
          else
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          Padding(
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
        ],
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
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).cardColor.withOpacity(0.9),
      shadowColor: Colors.black.withOpacity(0.3),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Theme.of(context).primaryColor),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: _getCardTextColor(context))),
        subtitle: Text(subtitle, style: TextStyle(color: _getCardTextColor(context).withOpacity(0.7))),
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Choose Theme',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _getCardTextColor(context)),
              ),
              const SizedBox(height: 8),
              Text(
                'Slide to choose',
                style: TextStyle(fontSize: 14, color: _getCardTextColor(context).withOpacity(0.6)),
              ),
              const SizedBox(height: 12),
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
                                Icon(
                                  Icons.check_circle,
                                  color: _getTextColor(theme),
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
                    style: TextButton.styleFrom(foregroundColor: Theme.of(context).primaryColor),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
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

  Color _getAppBarBackgroundColor(BuildContext context) {
    // Use a semi-transparent dark background for better visibility
    return Colors.black.withOpacity(0.7);
  }

  Color _getAppBarTextColor(BuildContext context) {
    // Always use white text for app bar for consistency
    return Colors.white;
  }

  Color _getCardTextColor(BuildContext context) {
    // Always use dark text for cards for better readability
    return Colors.black87;
  }

  void _contactUs(BuildContext context) {
    // Placeholder for contact functionality
    // Could open email or website
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact feature coming soon!')),
    );
  }
}