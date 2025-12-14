import 'package:equatable/equatable.dart';
import '../model/reputation_model.dart';

/// ReputationState - Represents different states of the reputation screen
abstract class ReputationState extends Equatable {
  const ReputationState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ReputationInitial extends ReputationState {}

/// Loading state (for initial load)
class ReputationLoading extends ReputationState {}

/// Loading more state (for pagination)
class ReputationLoadingMore extends ReputationState {
  final List<ReputationModel> currentReputation;

  const ReputationLoadingMore({required this.currentReputation});

  @override
  List<Object?> get props => [currentReputation];
}

/// Success state with loaded reputation history
class ReputationLoaded extends ReputationState {
  final List<ReputationModel> reputation;
  final bool hasMore;
  final int currentPage;

  const ReputationLoaded({
    required this.reputation,
    required this.hasMore,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [reputation, hasMore, currentPage];

  /// Create a copy with updated fields
  ReputationLoaded copyWith({
    List<ReputationModel>? reputation,
    bool? hasMore,
    int? currentPage,
  }) {
    return ReputationLoaded(
      reputation: reputation ?? this.reputation,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

/// Error state
class ReputationError extends ReputationState {
  final String message;
  final List<ReputationModel>? currentReputation;

  const ReputationError({required this.message, this.currentReputation});

  @override
  List<Object?> get props => [message, currentReputation];
}
