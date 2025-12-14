import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sof_task/core/di/injection.dart';
import 'package:sof_task/core/widgets/app_loader.dart';
import 'package:sof_task/core/widgets/empty_data_widget.dart';
import 'package:sof_task/core/widgets/error_widget.dart';
import 'package:sof_task/features/reputation/view/widgets/reputation_widget.dart';
import '../view_model/reputation_cubit.dart';
import '../view_model/reputation_state.dart';

/// ReputationScreen - Displays reputation history for a specific user
class ReputationScreen extends StatelessWidget {
  final int userId;
  final String userName;

  const ReputationScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReputationCubit>()..init(userId: userId),
      child: _ReputationScreenContent(userName: userName, userId: userId),
    );
  }
}

class _ReputationScreenContent extends StatefulWidget {
  final String userName;
  final int userId;

  const _ReputationScreenContent({
    required this.userName,
    required this.userId,
  });

  @override
  State<_ReputationScreenContent> createState() =>
      _ReputationScreenContentState();
}

class _ReputationScreenContentState extends State<_ReputationScreenContent> {
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
      context.read<ReputationCubit>().loadNextPage(userId: widget.userId);
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
      appBar: AppBar(
        title: Text('${widget.userName}\'s Reputation'),
        elevation: 2,
      ),
      body: BlocConsumer<ReputationCubit, ReputationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ReputationLoading) {
            return const AppLoader();
          }

          if (state is ReputationError && state.currentReputation == null) {
            return AppErrorWidget(message: state.message);
          }

          if (state is ReputationLoaded || state is ReputationLoadingMore) {
            final reputation = state is ReputationLoaded
                ? state.reputation
                : (state as ReputationLoadingMore).currentReputation;

            final hasMore = state is ReputationLoaded ? state.hasMore : false;

            if (reputation.isEmpty) {
              return EmptyDataWidget(
                title: 'No reputation history',
                message: 'This user has no reputation changes yet',
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<ReputationCubit>().refresh(
                userId: widget.userId,
              ),
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: reputation.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  // Show loading indicator at the bottom
                  if (index >= reputation.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: AppLoader(),
                    );
                  }

                  final item = reputation[index];
                  final dateFormat = DateFormat('MMM dd, yyyy HH:mm');

                  return ReputationWidget(item: item, dateFormat: dateFormat);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
