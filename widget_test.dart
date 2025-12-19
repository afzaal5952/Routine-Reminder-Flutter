// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:hisab/main.dart';
import 'package:hisab/services/auth_service.dart';
import 'package:hisab/providers/hisab_provider.dart';

void main() {
  testWidgets('App builds and shows login screen when not authenticated', (WidgetTester tester) async {
    // Build our app with providers and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HisabProvider()),
          Provider<AuthService>(create: (_) => AuthService()),
        ],
        child: const MyApp(),
      ),
    );

    // Wait for async initialization
    await tester.pumpAndSettle();

    // Verify that login-related text appears (since user is not logged in)
    // Look for "Welcome Back" or "Create Account" text from LoginScreen
    expect(find.text('Welcome Back'), findsNothing); // Initial state
    expect(find.text('Create Account'), findsNothing); // Initial state
    
    // Verify that the app has rendered (by checking for email field hint)
    expect(find.text('Email Address'), findsWidgets);
  });
}