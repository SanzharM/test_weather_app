import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:test_weather_app/Library/api/api_response.dart';
import 'package:test_weather_app/Library/configuration/config.dart';

enum Method { get, post, put, delete }

class Api {
  final _dio = _createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: AppConfig.host));

  static void logResponse(Response response) {
    debugPrint('\n----------');
    debugPrint('URL: ${response.realUri.toString()}');
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Request Options: ${response.requestOptions.data}');
    debugPrint('Response data: ${response.data}');
    debugPrint('----------');
  }

  static Dio _createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.host,
        receiveTimeout: 15000, // 15 seconds
        connectTimeout: 15000,
        sendTimeout: 15000,
        contentType: 'application/json',
      ),
    );

    return dio;
  }

  Future<ApiResponse> request({
    required String url,
    required Method method,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    void Function(int, int)? onSendProgress,
  }) async {
    Response response;
    try {
      switch (method) {
        case Method.get:
          response = await _dio.get(
            url,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case Method.post:
          response = await _dio.post(
            url,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case Method.put:
          response = await _dio.put(
            url,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case Method.delete:
          response = await _dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          );
          break;
      }
      logResponse(response);

      final bool isSuccess = (response.statusCode ?? -1) >= 200 && (response.statusCode ?? -1) <= 299;
      return ApiResponse(
        statusCode: response.statusCode,
        isSuccess: isSuccess,
        poorResponse: response,
        error: isSuccess ? null : await compute(parseError, response),
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
    return const ApiResponse(statusCode: -1, isSuccess: false, poorResponse: null, error: 'Something went wrong');
  }

  static Future<String> parseError(Response response) async {
    try {
      final body = jsonDecode(response.data);
      String? error = body['details'] ?? body['error'];
      if (error == null) {
        switch (response.statusCode) {
          case 400:
            return 'Bad request';
          case 401:
            return 'Unauthorized access';
          case 403:
            return 'Unauthorized access';
          case 404:
            return 'Not found';
          case 500:
            return 'Something went wrong. Try again later';
          default:
            return 'Error';
        }
      }
      return error;
    } catch (e) {
      debugPrint('$e');
    }
    return 'Error';
  }
}
