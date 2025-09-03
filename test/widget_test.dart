// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cliclock/main.dart';
import 'package:cliclock/providers/settings_provider.dart';
import 'package:cliclock/screens/clock_screen.dart';

void main() {
  testWidgets('App builds without error', (WidgetTester tester) async {
    // Create a settings provider
    final settingsProvider = SettingsProvider();
    await settingsProvider.loadSettings();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(settingsProvider: settingsProvider, showOnboarding: false));

    // Verify that the clock screen is displayed
    expect(find.byType(ClockScreen), findsOneWidget);
  });
}
