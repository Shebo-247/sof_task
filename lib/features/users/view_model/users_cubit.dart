import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sof_task/features/users/repository/users_repository.dart';
import '../../../core/services/storage_service.dart';
import '../model/user_model.dart';
import 'users_state.dart';

@injectable
class UsersCubit extends Cubit<UsersState> {
  final UsersRepository usersRepository;
  final StorageService localStorage;

  // Internal state management
  List<UserModel> _allUsers = [];
  List<UserModel> _bookmarkedUsers = [];
  List<int> _bookmarkedIds = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _showOnlyBookmarked = false;
  bool _isLoading = false;

  UsersCubit(this.usersRepository, this.localStorage) : super(UsersInitial());

  /// Initialize and load first page of users
  Future<void> init() async {
    emit(UsersLoading());
    await loadBookmarks();
    await getUsers(page: 1);
  }

  /// Load bookmarked user IDs from local storage
  Future<void> loadBookmarks() async {
    try {
      _bookmarkedUsers = await localStorage.getBookmarkedUsers();
      _bookmarkedIds = _bookmarkedUsers.map((user) => user.userId).toList();
    } catch (e) {
      debugPrint('Error loading bookmarks: $e');
      _bookmarkedUsers = [];
      _bookmarkedIds = [];
    }
  }

  /// Fetch users from API
  Future<void> getUsers({required int page}) async {
    if (_isLoading) return;

    try {
      _isLoading = true;

      // Show loading more state if we already have users
      if (_allUsers.isNotEmpty && state is UsersLoaded) {
        final currentState = state as UsersLoaded;
        emit(
          UsersLoadingMore(
            currentUsers: currentState.displayedUsers,
            bookmarkedIds: _bookmarkedIds,
            showOnlyBookmarked: _showOnlyBookmarked,
          ),
        );
      }

      final userResponse = await usersRepository.fetchUsers(
        page: page,
        pageSize: 10,
      );

      // Add new users to the list
      if (page == 1) {
        _allUsers = userResponse.items;
      } else {
        _allUsers.addAll(userResponse.items);
      }

      _currentPage = page;
      _hasMore = userResponse.hasMore;

      // Apply filter and emit success state
      _emitLoadedState();
    } catch (e) {
      _isLoading = false;
      emit(
        UsersError(
          message: e.toString(),
          currentUsers: _allUsers,
          bookmarkedIds: _bookmarkedIds,
          showOnlyBookmarked: _showOnlyBookmarked,
        ),
      );
    } finally {
      _isLoading = false;
    }
  }

  /// Load next page (for infinite scroll)
  Future<void> loadNextPage() async {
    if (!_hasMore || _isLoading || _showOnlyBookmarked) return;
    await getUsers(page: _currentPage + 1);
  }

  /// Toggle bookmark for a user
  Future<void> toggleBookmark(UserModel user) async {
    try {
      if (isBookmarked(user.userId)) {
        _bookmarkedUsers.removeWhere(
          (element) => element.userId == user.userId,
        );
        _bookmarkedIds.remove(user.userId);
      } else {
        _bookmarkedUsers.add(user);
        _bookmarkedIds.add(user.userId);
      }

      // Save to local storage
      await localStorage.saveBookmarkedUsers(_bookmarkedUsers);

      // Update UI
      _emitLoadedState();
    } catch (e) {
      debugPrint('Error toggling bookmark: $e');
    }
  }

  /// Filter to show only bookmarked users
  void filterOnlyBookmarked(bool isEnabled) {
    _showOnlyBookmarked = isEnabled;
    _emitLoadedState();
  }

  /// Check if a user is bookmarked
  bool isBookmarked(int userId) {
    return _bookmarkedIds.contains(userId);
  }

  /// Emit loaded state with filtered users
  void _emitLoadedState() {
    List<UserModel> displayedUsers;

    if (_showOnlyBookmarked) {
      // Show only bookmarked users
      displayedUsers = _allUsers
          .where((user) => _bookmarkedIds.contains(user.userId))
          .toList();
    } else {
      // Show all users
      displayedUsers = _allUsers;
    }

    emit(
      UsersLoaded(
        users: _allUsers,
        displayedUsers: displayedUsers,
        bookmarkedIds: _bookmarkedIds,
        hasMore: _hasMore && !_showOnlyBookmarked,
        showOnlyBookmarked: _showOnlyBookmarked,
        currentPage: _currentPage,
      ),
    );
  }

  /// Refresh users (pull to refresh)
  Future<void> refresh() async {
    _allUsers.clear();
    _currentPage = 1;
    _hasMore = true;
    _showOnlyBookmarked = false;
    await getUsers(page: 1);
  }
}
