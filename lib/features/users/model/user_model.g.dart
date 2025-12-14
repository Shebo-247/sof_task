// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  userId: (json['user_id'] as num).toInt(),
  displayName: json['display_name'] as String,
  profileImage: json['profile_image'] as String?,
  reputation: (json['reputation'] as num).toInt(),
  badgeCounts: json['badge_counts'] == null
      ? null
      : BadgeCounts.fromJson(json['badge_counts'] as Map<String, dynamic>),
  link: json['link'] as String?,
  accountId: (json['account_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'user_id': instance.userId,
  'display_name': instance.displayName,
  'profile_image': instance.profileImage,
  'reputation': instance.reputation,
  'badge_counts': instance.badgeCounts,
  'link': instance.link,
  'account_id': instance.accountId,
};

BadgeCounts _$BadgeCountsFromJson(Map<String, dynamic> json) => BadgeCounts(
  bronze: (json['bronze'] as num).toInt(),
  silver: (json['silver'] as num).toInt(),
  gold: (json['gold'] as num).toInt(),
);

Map<String, dynamic> _$BadgeCountsToJson(BadgeCounts instance) =>
    <String, dynamic>{
      'bronze': instance.bronze,
      'silver': instance.silver,
      'gold': instance.gold,
    };

UsersResponse _$UsersResponseFromJson(Map<String, dynamic> json) =>
    UsersResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['has_more'] as bool,
      quotaMax: (json['quota_max'] as num?)?.toInt(),
      quotaRemaining: (json['quota_remaining'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UsersResponseToJson(UsersResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'has_more': instance.hasMore,
      'quota_max': instance.quotaMax,
      'quota_remaining': instance.quotaRemaining,
    };
