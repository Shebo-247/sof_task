import 'package:injectable/injectable.dart';
import 'package:sof_task/core/network/dio_client.dart';
import 'package:sof_task/core/network/endpoints.dart';
import 'package:sof_task/core/network/error/api_failure.dart';
import 'package:sof_task/features/reputation/model/reputation_model.dart';

@lazySingleton
class ReputationRepository {
  final DioClient dioClient;

  ReputationRepository(this.dioClient);

  Future<ReputationResponse> getReputationHistory({
    required int userId,
    required int page,
  }) async {
    try {
      final response = await dioClient.get(
        endpoint: Endpoints.userReputation(userId: userId, page: page),
      );
      return ReputationResponse.fromJson(response);
    } on ApiFailure catch (_) {
      rethrow;
    }
  }
}
