import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/settings_provider.dart';
import 'screens/clock_screen.dart';
import 'screens/settings_screen.dart';
import 'themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  final settingsProvider = SettingsProvider();
  await settingsProvider.loadSettings();
  runApp(MyApp(settingsProvider: settingsProvider));
}

class MyApp extends StatelessWidget {
  final SettingsProvider settingsProvider;

  const MyApp({super.key, required this.settingsProvider});

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
            routes: {
              '/': (context) => const ClockScreen(),
              '/settings': (context) => const SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
