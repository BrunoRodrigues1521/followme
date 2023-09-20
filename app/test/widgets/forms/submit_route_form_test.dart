import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:followme/screens/submit_route_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() {
  group('Submit Route Form tests', () {
    testWidgets('Form Rendering', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SubmitRouteScreen(),));
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsNWidgets(4));
      expect(find.byType(ToggleSwitch), findsNWidgets(1));
      expect(find.text('add Images'), findsOneWidget);
      expect(find.text('Name:'), findsOneWidget);
      expect(find.text('Description:'), findsOneWidget);
      expect(find.text('Difficulty:'), findsOneWidget);
      expect(find.text('Visibility:'), findsOneWidget);
      expect(find.text('Tags:'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
    });
    testWidgets('Form inputs', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SubmitRouteScreen(),));
      final Finder name = find.widgetWithText(TextFormField, 'Insert route name');
      final Finder description = find.widgetWithText(TextFormField, 'Insert your description');
      final Finder visibilityPrivate = find.widgetWithText(ElevatedButton, 'Private');
      final Finder visibilityPublic = find.widgetWithText(ElevatedButton, 'Public');
      final Finder tags = find.widgetWithText(TextFormField, 'Insert some tags');
      final Finder submit = find.widgetWithText(ElevatedButton, 'Continue');

      await tester.enterText(name, 'Route 1');
      await tester.enterText(description, 'Some nice description');
      await tester.tap(visibilityPrivate);
      await tester.tap(visibilityPublic);
      await tester.enterText(tags,"travel fly visit");
      await tester.pump(const Duration(milliseconds: 1500));

      expect(find.text('Route 1'), findsOneWidget);
      expect(find.text('Some nice description'), findsOneWidget);
      expect(find.text('travel'), findsOneWidget); ///find three rendered tags below input
      expect(find.text('fly'), findsOneWidget);
      expect(find.text('visit'), findsOneWidget);
      await tester.tap(submit);
    });

    testWidgets('Validation error messages: Empty fields', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SubmitRouteScreen(),));
      final Finder submit = find.widgetWithText(ElevatedButton, 'Continue');
      await tester.tap(submit);
      await tester.pump(const Duration(milliseconds: 1500));
      expect(find.text('Empty Fields'), findsOneWidget);

    });
  });
}