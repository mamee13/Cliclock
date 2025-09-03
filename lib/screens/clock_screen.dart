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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>().settings;
    final now = DateTime.now();
    final timeFormat = settings.showSeconds ? 'HH:mm:ss' : 'HH:mm';
    final time = DateFormat(timeFormat).format(now);
    final date = settings.showDate ? DateFormat('EEEE, MMMM d, y').format(now) : null;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showSettingsButton = !_showSettingsButton;
          });
        },
        child: Stack(
          children: [
            // Background gradient for neon theme
            if (settings.theme == AppThemes.neon)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Color(0xFF0D0D0D)],
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
              child: Positioned(
                top: 50,
                right: 30,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
                  elevation: 8,
                  onPressed: () => Navigator.pushNamed(context, '/settings'),
                  child: const Icon(Icons.settings, size: 28),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}