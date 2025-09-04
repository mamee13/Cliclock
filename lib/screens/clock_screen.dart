import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
import '../themes.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late Timer _timer;
  bool _showSettingsButton = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>().settings;
    final now = DateTime.now();
    final timeFormat = settings.showSeconds ? 'HH:mm:ss' : 'HH:mm';
    final time = DateFormat(timeFormat).format(now);
    final date = settings.showDate
        ? DateFormat('EEEE, MMMM d, y').format(now)
        : null;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showSettingsButton = !_showSettingsButton;
          });
        },
        child: Stack(
          children: [
            // Background gradients for themes
            if (settings.theme == AppThemes.neon)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Color(0xFF0D0D0D)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.gradient)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purple, Colors.pink, Colors.orange],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.ocean)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF006994), Color(0xFF00D4FF)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.sunset)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFF6B35), Color(0xFFF7931E), Color(0xFFFFDC00)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.forest)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF0B6623), Color(0xFF228B22), Color(0xFF90EE90)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.cosmic)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF0F0F23), Color(0xFF1a1a2e), Color(0xFF16213e)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.fire)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFF4500), Color(0xFFFF6347), Color(0xFFFFD700)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.ice)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF00BFFF), Color(0xFF87CEEB), Color(0xFFE0FFFF)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.desert)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD2691E), Color(0xFFF4A460), Color(0xFFFFDAB9)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.galaxy)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF2E1A47), Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.aurora)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF0F1419), Color(0xFF1E3A8A), Color(0xFF06B6D4)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.storm)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF1F2937), Color(0xFF374151), Color(0xFF6B7280)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.meadow)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF16A34A), Color(0xFF22C55E), Color(0xFF86EFAC)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.candy)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFEC4899), Color(0xFFF97316), Color(0xFFF59E0B)],
                  ),
                ),
              )
            else if (settings.theme == AppThemes.vintage)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF92400E), Color(0xFFD97706), Color(0xFFFCD34D)],
                  ),
                ),
              ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      time,
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (date != null)
                      Text(
                        date,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _showSettingsButton ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24, bottom: 16),
                      child: FloatingActionButton(
                        heroTag: "timer",
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
                        elevation: 8,
                        onPressed: () => Navigator.pushNamed(context, '/timer'),
                        child: const Icon(Icons.timer, size: 28),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24, bottom: 24),
                      child: FloatingActionButton(
                        heroTag: "settings",
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
                        elevation: 8,
                        onPressed: () => Navigator.pushNamed(context, '/settings'),
                        child: const Icon(Icons.settings, size: 28),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
