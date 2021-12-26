import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:findcaption/core/config/api.dart';
import 'package:findcaption/core/services/base/config_services.dart';
import 'package:findcaption/core/utils/dialog/dialog_utils.dart';
import 'package:findcaption/core/utils/navigation/navigation_utils.dart';
import 'package:findcaption/injector.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// ignore: constant_identifier_names
enum RequestType { GET, POST, DELETE, PATCH, PUT }

class BaseServices extends ConfigServices {
  late Dio _dio;
  late Options _headersOption;
  BaseServices() {
    _dio = Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    
    /// Only show logging in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true
      ));
    }
  }

  /// For dependency injection
  var api = locator<Api>();

  /// Request HTTP Function
  /// 
  /// You must provide some parameter like [url], [type], and the other
  /// parameter like [data], [useToken], [useFormData] and [param] is optional
  Future<dynamic> request(String url, RequestType type, {dynamic data, bool useFormData = true, Map<String, dynamic>? param, bool useJsonContent = false}) async {
    dynamic response;

    _headersOption = await getHeaders(useJsonConten: useJsonContent);
    try {
      switch (type) {

        case RequestType.POST:
          response = await _dio.post(url,
              data: data != null ? (useFormData ? FormData.fromMap(await data) : data) : null, 
              options: _headersOption,
            );
          break;
          
        case RequestType.GET:
          param ??= <String, dynamic>{};
          response = await _dio.get(url, options: _headersOption, queryParameters: param);
          break;

        case RequestType.DELETE:
          response = await _dio.delete(url,
              data: data, options: _headersOption);
          break;
          
        case RequestType.PATCH:
          response = await _dio.patch(url,
              data: data != null ? (useFormData ? FormData.fromMap(await data) : data) : null, options: _headersOption);
          break;

        case RequestType.PUT:
          response = await _dio.put(url,
              data: data != null ? (useFormData ? FormData.fromMap(await data) : data) : null, 
              options: _headersOption,
            );
          break;
      }
    } on DioError catch (e) {
      if (e.message.contains("SocketException")) {
        navigate.pop();

        alertProblem("Your Internet In Problem",
          "Please check your internet connection and try again",
          callback: () async {
            /// Call this function again
            navigate.pop();
            request(url, type, data: data, param: param);
          }
        ); 
      }
      response = e.response;

      if (response.statusCode >= 500) {
        alertProblem("Ups Something Wrong",
          "Please try again later",
          callback: () async {
            /// Call this function again
            navigate.pop();
            request(url, type, data: data, param: param);
          }
        );
        throw Exception("Terjadi kesalahan, Unauthenticated");
      }
    }

    try {
      if (response != null) {
        /// Get status code and set to response
        int statusCode = response.statusCode;
        
        /// Converting response to json
        response = json.decode(response.toString());

        /// Adding status code
        response["status_code"] = statusCode;
        return response;
      } else {
        await alertProblem("Your Internet In Problem",
          "Please check your internet connection and try again",
          callback: () async {
            /// Call this function again
            navigate.pop();
            request(url, type, data: data, param: param);
          }
        ); 
      }
      
    } on Exception catch(_) {
      
    }
  }

  Future alertProblem(String title, String description, {Function? callback}) async {
    DialogShow.showInfo(description,
      title, 
      "Try Again",  
      onClick: () => callback!(),
    );
  }
}
