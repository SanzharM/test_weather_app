import 'package:dio/dio.dart';

class ApiResponse {
  final bool isSuccess;
  final int? statusCode;
  final Response? poorResponse;
  final String? error;

  const ApiResponse({
    this.isSuccess = false,
    required this.statusCode,
    this.poorResponse,
    this.error,
  });
}
