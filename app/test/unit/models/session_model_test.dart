import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:followme/model/session_model.dart';

void main() {
  group('Session model Tests', ()
  {
    test('Insert data to Model', () {
      SessionModel model = SessionModel(displayName: "testUser", email: "testUser@gmail.com", token: "abcd");

      expect(model.displayName, "testUser");
      expect(model.email, "testUser@gmail.com");
      expect(model.token, "abcd");
    });
    test('Test json decoding/mapping to object', () {
      final file = File('test/resources/session.json').readAsStringSync();
      final model = SessionModel.fromJson(jsonDecode(file) as Map<String, dynamic>);

      expect(model.displayName, "testUser");
      expect(model.email, "testUser@gmail.com");
      expect(model.token, "abcd");
    });
  });
}