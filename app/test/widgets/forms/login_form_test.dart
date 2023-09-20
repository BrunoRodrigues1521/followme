import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:followme/screens/login_screen.dart';

void main() {
  group('Login Form tests', () {
    testWidgets('Form Rendering', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen(),));
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsNWidgets(2));
      expect(find.text('Email:'), findsOneWidget);
      expect(find.text('Password:'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Sign In with Google'), findsOneWidget);
    });
    testWidgets('Form Inputs', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen(),));
      final Finder email = find.widgetWithText(TextFormField, 'Insert your email');
      final Finder password = find.widgetWithText(TextFormField, 'Insert your password');
      final Finder submit = find.widgetWithText(ElevatedButton, 'Login');
      await tester.enterText(email, 'testUser@gmail.com');
      await tester.enterText(password, 'testUser123456');
      await tester.tap(submit);

      expect(find.text('testUser@gmail.com'), findsOneWidget);
      expect(find.text('testUser123456'), findsOneWidget);


    });

    testWidgets('Validation error messages: Empty Fields', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: LoginScreen(),));
        final Finder email = find.widgetWithText(TextFormField, 'Insert your email');
        final Finder password = find.widgetWithText(TextFormField, 'Insert your password');
        final Finder submit = find.widgetWithText(ElevatedButton, 'Login');
        await tester.enterText(email, 'testUser@gmail.com');
        await tester.enterText(password, ''); //empty field
        await tester.tap(submit);
        await tester.pump(const Duration(milliseconds: 1500));

        expect(find.text('Empty Fields'), findsOneWidget);

    });

    testWidgets('Validation error messages: Wrong Email Format', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen(),));
      final Finder email = find.widgetWithText(TextFormField, 'Insert your email');
      final Finder password = find.widgetWithText(TextFormField, 'Insert your password');
      final Finder submit = find.widgetWithText(ElevatedButton, 'Login');
      await tester.enterText(email, 'testUsergmail.com');
      await tester.enterText(password, 'testUser123456'); //empty field
      await tester.tap(submit);
      await tester.pump(const Duration(milliseconds: 1500));

      expect(find.text('Insert a valid email adress'), findsOneWidget);

    });

    testWidgets('Validation error messages: Wrong Password Format', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen(),));
      final Finder email = find.widgetWithText(TextFormField, 'Insert your email');
      final Finder password = find.widgetWithText(TextFormField, 'Insert your password');
      final Finder submit = find.widgetWithText(ElevatedButton, 'Login');
      await tester.enterText(email, 'testUser@gmail.com');
      await tester.enterText(password, '1testUser123456'); //empty field
      await tester.tap(submit);
      await tester.pump(const Duration(milliseconds: 1500));

      expect(find.text('Password must be between 7 to 20 characters which contain only characters, numeric digits and underscore and first character must be a letter'), findsOneWidget);

    });
  });
}

