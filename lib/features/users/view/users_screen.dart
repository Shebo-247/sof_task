import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sof_task/core/di/injection.dart';
import 'package:sof_task/core/widgets/app_loader.dart';
import 'package:sof_task/core/widgets/empty_data_widget.dart';
import 'package:sof_task/core/widgets/error_widget.dart';
import '../../reputation/view/reputation_screen.dart';
import '../view_model/users_cubit.dart';
import '../view_model/users_state.dart';
import 'widgets/user_item.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UsersCubit>()..init(),
      child: const _UsersScreenContent(),
    );
  }
}

class _UsersScreenContent extends StatefulWidget {
  const _UsersScreenContent();

  @override
  State<_UsersScreenContent> createState() => _UsersScreenContentState();
}

class _UsersScreenContentState extends State<_UsersScreenContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Handle scroll for infinite scrolling
  void _onScroll() {
    if (_isBottom) {
      context.read<UsersCubit>().loadNextPage();
    }
  }

  /// Check if scrolled to bottom
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('StackOverflow Users'), elevation: 2),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Bookmarks Only',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                BlocBuilder<UsersCubit, UsersState>(
                  builder: (context, state) {
                    bool isFilterEnabled = false;

                    if (state is UsersLoaded) {
                      isFilterEnabled = state.showOnlyBookmarked;
                    } else if (state is UsersLoadingMore) {
                      isFilterEnabled = state.showOnlyBookmarked;
                    }

                    return Transform.scale(
                      scale: 0.7,
                      child: Switch(
                        value: isFilterEnabled,
                        onChanged: (value) {
                          context.read<UsersCubit>().filterOnlyBookmarked(
                            value,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<UsersCubit, UsersState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is UsersLoading) {
                  return const AppLoader();
                }

                if (state is UsersError && state.currentUsers == null) {
                  return AppErrorWidget(
                    message: state.message,
                    onRetry: () => context.read<UsersCubit>().refresh(),
                  );
                }

                if (state is UsersLoaded || state is UsersLoadingMore) {
                  final displayedUsers = state is UsersLoaded
                      ? state.displayedUsers
                      : (state as UsersLoadingMore).currentUsers;

                  final bookmarkedIds = state is UsersLoaded
                      ? state.bookmarkedIds
                      : (state as UsersLoadingMore).bookmarkedIds;

                  final hasMore = state is UsersLoaded ? state.hasMore : false;

                  if (displayedUsers.isEmpty) {
                    return EmptyDataWidget(
                      title: 'No bookmarked users',
                      message: 'Tap the bookmark icon to save users',
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => context.read<UsersCubit>().refresh(),
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: displayedUsers.length + (hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        // Show loading indicator at the bottom
                        if (index >= displayedUsers.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: AppLoader(),
                          );
                        }

                        final user = displayedUsers[index];
                        final isBookmarked = bookmarkedIds.contains(
                          user.userId,
                        );

                        return UserItem(
                          user: user,
                          isBookmarked: isBookmarked,
                          onTap: () {
                            // Navigate to reputation screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReputationScreen(
                                  userId: user.userId,
                                  userName: user.displayName,
                                ),
                              ),
                            );
                          },
                          onBookmarkToggle: () {
                            setState(() {
                              context.read<UsersCubit>().toggleBookmark(user);
                            });
                          },
                        );
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
