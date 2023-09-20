import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:followme/model/submit_route_model.dart';

void main() {
  group('Submit route model Tests', ()
  {
    test('Insert data to Model', () {
      SubmitRouteModel model = SubmitRouteModel(success: 1,error: "error");

      expect(model.success, 1);
      expect(model.error, "error");
    });
    test('Test json decoding/mapping to object', () {
      final file = File('test/resources/submit_route.json').readAsStringSync();
      final model = SubmitRouteModel.fromJson(jsonDecode(file) as Map<String, dynamic>);

      expect(model.success, 1);
      expect(model.error, "error");
    });
  });
}