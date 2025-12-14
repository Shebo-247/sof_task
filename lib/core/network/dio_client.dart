import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sof_task/core/network/endpoints.dart';
import 'package:sof_task/core/network/error/api_failure.dart';

@lazySingleton
class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio();

    _dio.options = BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(minutes: 30),
      sendTimeout: const Duration(seconds: 30),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(requestHeader: true, requestBody: true, maxWidth: 1000),
      );
    }
  }

  Future get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: options,
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiFailure.fromDioException(e);
    }
  }

  Future post({
    required String endpoint,
    dynamic data,
    Options? options,
    Map<String, dynamic>? queryParams,
    bool isFormData = false,
  }) async {
    try {
      // Entire map of response
      final response = await _dio.post(
        endpoint,
        data: isFormData ? FormData.fromMap(data) : data,
        options: options,
        queryParameters: queryParams,
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiFailure.fromDioException(e);
    }
  }

  Future patch({
    required String endpoint,
    Map<String, dynamic>? data,
    Options? options,
    bool isFormData = false,
  }) async {
    try {
      // Entire map of response
      final response = await _dio.patch(
        endpoint,
        data: isFormData ? FormData.fromMap(data!) : data,
        options: options,
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiFailure.fromDioException(e);
    }
  }

  Future update({
    required String endpoint,
    required Map<String, dynamic> data,
    Options? options,
  }) async {
    try {
      // Entire map of response
      final response = await _dio.put(endpoint, data: data, options: options);

      return response.data;
    } on DioException catch (e) {
      throw ApiFailure.fromDioException(e);
    }
  }

  Future delete({
    required String endpoint,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      // Entire map of response
      final response = await _dio.delete(
        endpoint,
        data: data,
        options: options,
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiFailure.fromDioException(e);
    }
  }
}
