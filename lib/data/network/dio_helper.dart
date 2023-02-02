import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHandler {
  Dio dio = Dio()
    ..interceptors.add(InterceptorsWrapper(
      onResponse: (Response res, handler) {
        if (kDebugMode) {
          print("Response: ${{
            "method": res.requestOptions.method,
            "url": res.requestOptions.baseUrl + res.requestOptions.path,
            "body": res.data,
          }}");
        }
        handler.next(res);
      },
      onRequest: (RequestOptions req, handler) {
        log("Request: ${{
          "method": req.method,
          "url": req.baseUrl + req.path,
          "data": req.data is FormData ? req.data.fields : req.data,
          "params": req.queryParameters
        }}");
        handler.next(req);
      },
      onError: (DioError err, handler) {
        log("Error: ${err.response?.statusCode} - ${err.requestOptions.baseUrl}${err.requestOptions.path} - ${err.response?.data}");
        handler.next(err);
      },
    ));

  static Future<String?> parseDioErrorMessage(DioError e) async {
    String error;
    switch (e.type) {
      case DioErrorType.connectTimeout:
        error = "Connection Timeout";
        break;
      case DioErrorType.sendTimeout:
        error = "Send Timeout";
        break;
      case DioErrorType.receiveTimeout:
        error = "Receive Timeout";
        break;
      case DioErrorType.response:
        error = "Error ${e.response?.statusCode}";
        break;
      case DioErrorType.cancel:
        error = "Error connection cancelled";
        break;
      case DioErrorType.other:
        error = "Unknown Error";
        break;
    }
    return error;
  }
}

Dio dio = DioHandler().dio;
