/// API Endpoints for StackExchange API
class Endpoints {
  // Base URL
  static const String baseUrl = 'https://api.stackexchange.com/2.2';

  // Site parameter
  static const String site = 'stackoverflow';

  // Users endpoint
  static String users({required int page, int pageSize = 30}) {
    return '$baseUrl/users?page=$page&pagesize=$pageSize&site=$site';
  }

  // User reputation history endpoint
  static String userReputation({
    required int userId,
    required int page,
    int pageSize = 30,
  }) {
    return '$baseUrl/users/$userId/reputation-history?page=$page&pagesize=$pageSize&site=$site';
  }
}
