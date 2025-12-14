import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sof_task/core/network/error/response_codes.dart';

abstract class Failure extends Equatable {
  final String? message;
  final int? statusCode;

  const Failure({this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  factory ApiFailure.fromDioException(DioException e) {
    switch (e.response?.statusCode ?? ResponseCodes.serverError) {
      case ResponseCodes.badRequest:
        return ApiFailure(
          statusCode: ResponseCodes.badRequest,
          message: 'Bad Request',
        );
      case ResponseCodes.unauthorized:
        return ApiFailure(
          statusCode: ResponseCodes.unauthorized,
          message: 'Unauthorized',
        );
      case ResponseCodes.notFound:
        return ApiFailure(
          statusCode: ResponseCodes.notFound,
          message: e.response?.data['msg'] ?? 'Not Found',
        );
      case ResponseCodes.unprocessableContent:
        return ApiFailure(
          statusCode: ResponseCodes.unprocessableContent,
          message: e.response?.data['msg'] ?? 'Not Found',
        );
      case ResponseCodes.methodNotAllowed:
        return ApiFailure(
          statusCode: ResponseCodes.methodNotAllowed,
          message: e.response?.data['msg'] ?? 'Method Not Allowed',
        );
      case ResponseCodes.serverError:
        return ApiFailure(
          statusCode: ResponseCodes.serverError,
          message: 'Internal Server Error',
        );
      case ResponseCodes.manyRequest:
        return ApiFailure(
          statusCode: ResponseCodes.manyRequest,
          message: 'Too Many Attempts',
        );
      case ResponseCodes.paymentRequired:
        return ApiFailure(
          statusCode: ResponseCodes.paymentRequired,
          message: e.response?.data['msg'] ?? 'Payment Required',
        );
      default:
        return const ApiFailure(
          statusCode: -1,
          message: 'Something went wrong',
        );
    }
  }
}
