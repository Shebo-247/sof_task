// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reputation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReputationModel _$ReputationModelFromJson(Map<String, dynamic> json) =>
    ReputationModel(
      reputationHistoryType: json['reputation_history_type'] as String,
      reputationChange: (json['reputation_change'] as num).toInt(),
      postId: (json['post_id'] as num?)?.toInt(),
      creationDate: (json['creation_date'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$ReputationModelToJson(ReputationModel instance) =>
    <String, dynamic>{
      'reputation_history_type': instance.reputationHistoryType,
      'reputation_change': instance.reputationChange,
      'post_id': instance.postId,
      'creation_date': instance.creationDate,
      'user_id': instance.userId,
    };

ReputationResponse _$ReputationResponseFromJson(Map<String, dynamic> json) =>
    ReputationResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => ReputationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['has_more'] as bool,
      quotaMax: (json['quota_max'] as num?)?.toInt(),
      quotaRemaining: (json['quota_remaining'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReputationResponseToJson(ReputationResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'has_more': instance.hasMore,
      'quota_max': instance.quotaMax,
      'quota_remaining': instance.quotaRemaining,
    };
