import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/settings_provider.dart';
import 'screens/clock_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/timer_screen.dart';
import 'themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  final prefs = await SharedPreferences.getInstance();
  final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

  final settingsProvider = SettingsProvider();
  await settingsProvider.loadSettings();

  runApp(MyApp(
    settingsProvider: settingsProvider,
    showOnboarding: !onboardingCompleted,
  ));
}

class MyApp extends StatelessWidget {
  final SettingsProvider settingsProvider;
  final bool showOnboarding;

  const MyApp({
    super.key,
    required this.settingsProvider,
    required this.showOnboarding,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: settingsProvider,
      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Cliclock',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.getTheme(provider.settings.theme),
            initialRoute: showOnboarding ? '/onboarding' : '/',
            routes: {
              '/': (context) => const ClockScreen(),
              '/onboarding': (context) => const OnboardingScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/contact': (context) => const ContactScreen(),
              '/timer': (context) => const TimerScreen(),
            },
          );
        },
      ),
    );
  }
}
