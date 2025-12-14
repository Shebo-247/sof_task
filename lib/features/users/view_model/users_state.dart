import 'package:equatable/equatable.dart';
import '../model/user_model.dart';

/// UsersState - Represents different states of the users screen
abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class UsersInitial extends UsersState {}

/// Loading state (for initial load)
class UsersLoading extends UsersState {}

/// Loading more state (for pagination)
class UsersLoadingMore extends UsersState {
  final List<UserModel> currentUsers;
  final List<int> bookmarkedIds;
  final bool showOnlyBookmarked;

  const UsersLoadingMore({
    required this.currentUsers,
    required this.bookmarkedIds,
    required this.showOnlyBookmarked,
  });

  @override
  List<Object?> get props => [currentUsers, bookmarkedIds, showOnlyBookmarked];
}

/// Success state with loaded users
class UsersLoaded extends UsersState {
  final List<UserModel> users;
  final List<UserModel> displayedUsers;
  final List<int> bookmarkedIds;
  final bool hasMore;
  final bool showOnlyBookmarked;
  final int currentPage;

  const UsersLoaded({
    required this.users,
    required this.displayedUsers,
    required this.bookmarkedIds,
    required this.hasMore,
    required this.showOnlyBookmarked,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [
    users,
    displayedUsers,
    bookmarkedIds,
    hasMore,
    showOnlyBookmarked,
    currentPage,
  ];

  /// Create a copy with updated fields
  UsersLoaded copyWith({
    List<UserModel>? users,
    List<UserModel>? displayedUsers,
    List<int>? bookmarkedIds,
    bool? hasMore,
    bool? showOnlyBookmarked,
    int? currentPage,
  }) {
    return UsersLoaded(
      users: users ?? this.users,
      displayedUsers: displayedUsers ?? this.displayedUsers,
      bookmarkedIds: bookmarkedIds ?? this.bookmarkedIds,
      hasMore: hasMore ?? this.hasMore,
      showOnlyBookmarked: showOnlyBookmarked ?? this.showOnlyBookmarked,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

/// Error state
class UsersError extends UsersState {
  final String message;
  final List<UserModel>? currentUsers;
  final List<int>? bookmarkedIds;
  final bool? showOnlyBookmarked;

  const UsersError({
    required this.message,
    this.currentUsers,
    this.bookmarkedIds,
    this.showOnlyBookmarked,
  });

  @override
  List<Object?> get props => [
    message,
    currentUsers,
    bookmarkedIds,
    showOnlyBookmarked,
  ];
}
