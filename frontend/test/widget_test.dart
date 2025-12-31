import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:rent_mi/main.dart';
import 'package:rent_mi/core/constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock Firebase Core
  const MethodChannel channel = MethodChannel('plugins.flutter.io/firebase_core');
  
  setUpAll(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'Firebase#initializeCore') {
        return [
          {
            'name': '[DEFAULT]',
            'options': {
              'apiKey': '123',
              'appId': '123',
              'messagingSenderId': '123',
              'projectId': '123',
            },
            'pluginConstants': {},
          }
        ];
      }
      if (methodCall.method == 'Firebase#initializeApp') {
        return {
          'name': methodCall.arguments['appName'],
          'options': methodCall.arguments['options'],
          'pluginConstants': {},
        };
      }
      return null;
    });

    // Mock Firebase Auth
    const MethodChannel authChannel = MethodChannel('plugins.flutter.io/firebase_auth');
    authChannel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });
  });

  testWidgets('App initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RentMiApp());
    await tester.pumpAndSettle(); // Wait for async init

    // Verify that the login screen is shown
    expect(find.text(AppStrings.loginTitle), findsOneWidget);
    expect(find.text(AppStrings.phoneHint), findsOneWidget);
  });
}
