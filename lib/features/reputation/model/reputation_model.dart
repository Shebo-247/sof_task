import 'package:json_annotation/json_annotation.dart';

part 'reputation_model.g.dart';

/// ReputationModel - Represents a reputation history entry
@JsonSerializable()
class ReputationModel {
  @JsonKey(name: 'reputation_history_type')
  final String reputationHistoryType;

  @JsonKey(name: 'reputation_change')
  final int reputationChange;

  @JsonKey(name: 'post_id')
  final int? postId;

  @JsonKey(name: 'creation_date')
  final int creationDate;

  @JsonKey(name: 'user_id')
  final int userId;

  ReputationModel({
    required this.reputationHistoryType,
    required this.reputationChange,
    this.postId,
    required this.creationDate,
    required this.userId,
  });

  factory ReputationModel.fromJson(Map<String, dynamic> json) =>
      _$ReputationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReputationModelToJson(this);

  /// Get formatted date from timestamp
  DateTime get date {
    return DateTime.fromMillisecondsSinceEpoch(creationDate * 1000);
  }

  /// Get readable reputation type
  String get readableType {
    switch (reputationHistoryType) {
      case 'asker_accepts_answer':
        return 'Answer Accepted';
      case 'answer_accepted':
        return 'Your Answer Accepted';
      case 'post_upvoted':
        return 'Post Upvoted';
      case 'post_downvoted':
        return 'Post Downvoted';
      case 'bounty_given':
        return 'Bounty Given';
      case 'bounty_earned':
        return 'Bounty Earned';
      case 'post_flagged_as_spam':
        return 'Post Flagged as Spam';
      case 'suggested_edit_approval_received':
        return 'Edit Approved';
      default:
        return reputationHistoryType.replaceAll('_', ' ').toUpperCase();
    }
  }

  /// Get color based on reputation change
  bool get isPositive => reputationChange > 0;
}

/// ReputationResponse - API response wrapper
@JsonSerializable()
class ReputationResponse {
  final List<ReputationModel> items;

  @JsonKey(name: 'has_more')
  final bool hasMore;

  @JsonKey(name: 'quota_max')
  final int? quotaMax;

  @JsonKey(name: 'quota_remaining')
  final int? quotaRemaining;

  ReputationResponse({
    required this.items,
    required this.hasMore,
    this.quotaMax,
    this.quotaRemaining,
  });

  factory ReputationResponse.fromJson(Map<String, dynamic> json) =>
      _$ReputationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReputationResponseToJson(this);
}
