// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_parscrucis_cr/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Splash screen loads options', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const ParcrucisApp());

    expect(find.text('Parcrucis'), findsOneWidget);
    expect(find.text('NOVO\nPERSONAGEM'), findsOneWidget);
    expect(find.text('CARREGAR\nPERSONAGEM'), findsOneWidget);
  });
}
