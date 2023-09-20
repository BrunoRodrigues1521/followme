import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:followme/model/auth_model.dart';

void main() {
  group('Auth model Tests', ()
  {
    test('Insert data to Model', () {
      AuthResponseModel model = AuthResponseModel(success: 1, token: "abcd", error: "error");

      expect(model.success, 1);
      expect(model.token, "abcd");
      expect(model.error, "error");
    });
    test('Test json decoding/mapping to object', () {
      final file = File('test/resources/user.json').readAsStringSync();
      final model = AuthResponseModel.fromJson(jsonDecode(file) as Map<String, dynamic>);

      expect(model.success, 1);
      expect(model.token, "abcd");
      expect(model.error, "error");
    });
  });
}