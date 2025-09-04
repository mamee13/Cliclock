import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../providers/settings_provider.dart';
import '../themes.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;
  bool _isCountDown = false;
  int _initialSeconds = 0;
  
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();

  @override
  void dispose() {
    _timer?.cancel();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (_isRunning) return;
    
    setState(() {
      _isRunning = true;
    });
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_isCountDown) {
          if (_seconds > 0) {
            _seconds--;
          } else {
            _stopTimer();
            _showTimerFinishedDialog();
          }
        } else {
          _seconds++;
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _seconds = _isCountDown ? _initialSeconds : 0;
    });
  }

  void _setCountDownTimer() {
    final minutes = int.tryParse(_minutesController.text) ?? 0;
    final seconds = int.tryParse(_secondsController.text) ?? 0;
    final totalSeconds = (minutes * 60) + seconds;
    
    if (totalSeconds > 0) {
      setState(() {
        _isCountDown = true;
        _seconds = totalSeconds;
        _initialSeconds = totalSeconds;
      });
      Navigator.pop(context);
    }
  }

  void _setCountUpTimer() {
    setState(() {
      _isCountDown = false;
      _seconds = 0;
      _initialSeconds = 0;
    });
    Navigator.pop(context);
  }

  void _showTimerSetupDialog() {
    _minutesController.clear();
    _secondsController.clear();
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: _getDialogBackgroundColor(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 350),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Setup Timer',
                style: TextStyle(
                  color: _getTextColor(),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _minutesController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: _getTextColor()),
                      decoration: InputDecoration(
                        labelText: 'Minutes',
                        labelStyle: TextStyle(color: _getTextColor().withOpacity(0.7)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _getTextColor().withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _getAccentColor()),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _secondsController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: _getTextColor()),
                      decoration: InputDecoration(
                        labelText: 'Seconds',
                        labelStyle: TextStyle(color: _getTextColor().withOpacity(0.7)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _getTextColor().withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _getAccentColor()),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _setCountUpTimer,
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text('Count Up'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getAccentColor(),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _setCountDownTimer,
                    icon: const Icon(Icons.timer, size: 18),
                    label: const Text('Count Down'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getAccentColor(),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: _getTextColor()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTimerFinishedDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: _getDialogBackgroundColor(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300, maxHeight: 200),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Timer Finished!',
                style: TextStyle(
                  color: _getTextColor(),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your countdown timer has reached zero.',
                style: TextStyle(
                  color: _getTextColor(),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getAccentColor(),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  Color _getBackgroundColor() {
    final settingsProvider = context.watch<SettingsProvider>();
    final theme = settingsProvider.settings.theme;
    
    switch (theme) {
      case 'neon':
        return Colors.black;
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
        return Theme.of(context).scaffoldBackgroundColor;
    }
  }

  Color _getTextColor() {
    final settingsProvider = context.watch<SettingsProvider>();
    final theme = settingsProvider.settings.theme;
    
    switch (theme) {
      case 'light':
      case 'minimal':
        return Colors.black;
      case 'neon':
        return Colors.greenAccent;
      case 'retro':
        return Colors.brown;
      default:
        return Colors.white;
    }
  }

  Color _getAccentColor() {
    final settingsProvider = context.watch<SettingsProvider>();
    final theme = settingsProvider.settings.theme;
    
    switch (theme) {
      case 'neon':
        return Colors.greenAccent;
      case 'ocean':
        return Colors.cyanAccent;
      case 'sunset':
        return Colors.orangeAccent;
      case 'forest':
        return Colors.lightGreenAccent;
      case 'cosmic':
        return Colors.purpleAccent;
      case 'fire':
        return Colors.redAccent;
      case 'ice':
        return Colors.lightBlueAccent;
      case 'galaxy':
        return Colors.pinkAccent;
      case 'aurora':
        return Colors.greenAccent;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  Color _getDialogBackgroundColor() {
    final settingsProvider = context.watch<SettingsProvider>();
    final theme = settingsProvider.settings.theme;
    
    switch (theme) {
      case 'light':
      case 'minimal':
        return Colors.white;
      case 'dark':
        return Colors.grey[800]!;
      default:
        return _getBackgroundColor().withOpacity(0.9);
    }
  }

  List<Shadow> _getTextShadows() {
    final settingsProvider = context.watch<SettingsProvider>();
    final theme = settingsProvider.settings.theme;
    
    switch (theme) {
      case 'neon':
        return [Shadow(color: Colors.greenAccent, blurRadius: 20)];
      case 'cosmic':
        return [Shadow(color: Colors.purpleAccent, blurRadius: 15)];
      case 'galaxy':
        return [Shadow(color: Colors.pinkAccent, blurRadius: 15)];
      case 'aurora':
        return [Shadow(color: Colors.greenAccent, blurRadius: 15)];
      default:
        return [];
    }
  }

  Widget _buildGradientBackground() {
    final settingsProvider = context.watch<SettingsProvider>();
    final theme = settingsProvider.settings.theme;
    
    switch (theme) {
      case 'gradient':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.pink, Colors.orange],
            ),
          ),
        );
      case 'ocean':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF006994), Color(0xFF00D4FF)],
            ),
          ),
        );
      case 'sunset':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFF6B35), Color(0xFFF7931E), Color(0xFFFFDC00)],
            ),
          ),
        );
      case 'forest':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0B6623), Color(0xFF228B22), Color(0xFF90EE90)],
            ),
          ),
        );
      case 'cosmic':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0F0F23), Color(0xFF1a1a2e), Color(0xFF16213e)],
            ),
          ),
        );
      case 'fire':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFF4500), Color(0xFFFF6347), Color(0xFFFFD700)],
            ),
          ),
        );
      case 'ice':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF00BFFF), Color(0xFF87CEEB), Color(0xFFE0FFFF)],
            ),
          ),
        );
      case 'desert':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFD2691E), Color(0xFFF4A460), Color(0xFFFFDAB9)],
            ),
          ),
        );
      case 'galaxy':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2E1A47), Color(0xFF8B5CF6), Color(0xFFEC4899)],
            ),
          ),
        );
      case 'aurora':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0F1419), Color(0xFF1E3A8A), Color(0xFF06B6D4)],
            ),
          ),
        );
      case 'storm':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1F2937), Color(0xFF374151), Color(0xFF6B7280)],
            ),
          ),
        );
      case 'meadow':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF16A34A), Color(0xFF22C55E), Color(0xFF86EFAC)],
            ),
          ),
        );
      case 'candy':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFEC4899), Color(0xFFF97316), Color(0xFFF59E0B)],
            ),
          ),
        );
      case 'vintage':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF92400E), Color(0xFFD97706), Color(0xFFFCD34D)],
            ),
          ),
        );
      default:
        return Container(color: _getBackgroundColor());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGradientBackground(),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: _getTextColor(),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Image.asset(
                        'assets/icons/cliclock_logo.png',
                        width: 32,
                        height: 32,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Timer',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: _getTextColor(),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Timer Display
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            _isCountDown ? 'COUNTDOWN' : 'STOPWATCH',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: _getTextColor().withOpacity(0.8),
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 40),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              _formatTime(_seconds),
                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                color: _getTextColor(),
                                shadows: _getTextShadows(),
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                          
                          // Control Buttons
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              FloatingActionButton.extended(
                                onPressed: _showTimerSetupDialog,
                                backgroundColor: _getAccentColor(),
                                foregroundColor: Colors.white,
                                icon: const Icon(Icons.settings, size: 20),
                                label: const Text('Setup'),
                              ),
                              FloatingActionButton.extended(
                                onPressed: _isRunning ? _stopTimer : _startTimer,
                                backgroundColor: _isRunning ? Colors.red : Colors.green,
                                foregroundColor: Colors.white,
                                icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow, size: 20),
                                label: Text(_isRunning ? 'Pause' : 'Start'),
                              ),
                              FloatingActionButton.extended(
                                onPressed: _resetTimer,
                                backgroundColor: _getAccentColor().withOpacity(0.7),
                                foregroundColor: Colors.white,
                                icon: const Icon(Icons.refresh, size: 20),
                                label: const Text('Reset'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}