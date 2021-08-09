import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getx_pagination/model_test.dart';
import 'package:http/http.dart' as http;

class ApiService extends ApiUtil {
  var _timeout = Duration(seconds: 30);

  @override
  Future<void> get({
    required var url,
    required Function(
      bool success,
      String message,
      List<ModelTest> response,
    )
        callback,
  }) async {
    return http
        .get(Uri.parse(url))
        .then((value) {
          var _code = value.statusCode;
          List<ModelTest> data = modelTestFromMap(value.body);

          return callback(_code == 200 || _code == 201,
              _code == 200 || _code == 201 ? "Success" : "Failed", data);
        })
        .catchError((e) => callback(false, "Failed $e", []))
        .timeout(_timeout, onTimeout: () => callback(false, "Timeout", []));
  }
}

abstract class ApiUtil {
  Future<void> get({
    required String url,
    required VoidCallback callback(
      bool status,
      String message,
      List<ModelTest> response,
    ),
  });
}
