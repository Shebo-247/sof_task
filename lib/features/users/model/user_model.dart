import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// UserModel - Represents a StackOverflow user
@JsonSerializable()
class UserModel {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'display_name')
  final String displayName;

  @JsonKey(name: 'profile_image')
  final String? profileImage;

  final int reputation;

  @JsonKey(name: 'badge_counts')
  final BadgeCounts? badgeCounts;

  final String? link;

  @JsonKey(name: 'account_id')
  final int? accountId;

  UserModel({
    required this.userId,
    required this.displayName,
    this.profileImage,
    required this.reputation,
    this.badgeCounts,
    this.link,
    this.accountId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Format reputation with comma separators
  String get formattedReputation {
    return reputation.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}

/// BadgeCounts - Represents user's badge counts
@JsonSerializable()
class BadgeCounts {
  final int bronze;
  final int silver;
  final int gold;

  BadgeCounts({required this.bronze, required this.silver, required this.gold});

  factory BadgeCounts.fromJson(Map<String, dynamic> json) =>
      _$BadgeCountsFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeCountsToJson(this);
}

/// UsersResponse - API response wrapper
@JsonSerializable()
class UsersResponse {
  final List<UserModel> items;

  @JsonKey(name: 'has_more')
  final bool hasMore;

  @JsonKey(name: 'quota_max')
  final int? quotaMax;

  @JsonKey(name: 'quota_remaining')
  final int? quotaRemaining;

  UsersResponse({
    required this.items,
    required this.hasMore,
    this.quotaMax,
    this.quotaRemaining,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResponseToJson(this);
}
