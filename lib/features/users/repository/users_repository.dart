import 'package:injectable/injectable.dart';
import 'package:sof_task/core/network/dio_client.dart';
import 'package:sof_task/core/network/endpoints.dart';
import 'package:sof_task/core/network/error/api_failure.dart';
import 'package:sof_task/features/users/model/user_model.dart';

@lazySingleton
class UsersRepository {
  final DioClient dioClient;

  UsersRepository(this.dioClient);

  Future<UsersResponse> fetchUsers({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await dioClient.get(
        endpoint: Endpoints.users(page: page, pageSize: pageSize),
      );
      return UsersResponse.fromJson(response);
    } on ApiFailure catch (_) {
      rethrow;
    }
  }
}
