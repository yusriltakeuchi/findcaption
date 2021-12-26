import 'package:dio/dio.dart';

class ConfigServices {
  /// Generate default headers
  Future<Options> getHeaders({bool useJsonConten = false}) async {
    var _headers = <String, dynamic>{};
    _headers['Accept'] = "application/json";
    if (useJsonConten == true) {
      _headers['Content-Type'] = "application/json";
    }

    return Options(
      headers: _headers,
      sendTimeout: 5000,
      receiveTimeout: 5000
    );
  }
}
