import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sof_task/features/reputation/repository/reputation_repository.dart';
import '../model/reputation_model.dart';
import 'reputation_state.dart';

@injectable
class ReputationCubit extends Cubit<ReputationState> {
  final ReputationRepository _reputationRepository;

  // Internal state management
  List<ReputationModel> _reputationList = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoading = false;

  ReputationCubit(this._reputationRepository) : super(ReputationInitial());

  /// Initialize and load first page of reputation history
  Future<void> init({required int userId}) async {
    emit(ReputationLoading());
    await getReputation(page: 1, userId: userId);
  }

  /// Fetch reputation history from API
  Future<void> getReputation({required int page, required int userId}) async {
    if (_isLoading) return;

    try {
      _isLoading = true;

      // Show loading more state if we already have data
      if (_reputationList.isNotEmpty && state is ReputationLoaded) {
        emit(ReputationLoadingMore(currentReputation: _reputationList));
      }

      final reputationResponse = await _reputationRepository
          .getReputationHistory(userId: userId, page: page);

      // Add new reputation entries to the list
      if (page == 1) {
        _reputationList = reputationResponse.items;
      } else {
        _reputationList.addAll(reputationResponse.items);
      }

      _currentPage = page;
      _hasMore = reputationResponse.hasMore;

      emit(
        ReputationLoaded(
          reputation: _reputationList,
          hasMore: _hasMore,
          currentPage: _currentPage,
        ),
      );
    } catch (e) {
      emit(
        ReputationError(
          message: e.toString(),
          currentReputation: _reputationList.isEmpty ? null : _reputationList,
        ),
      );
    } finally {
      _isLoading = false;
    }
  }

  /// Load next page (for infinite scroll)
  Future<void> loadNextPage({required int userId}) async {
    if (!_hasMore || _isLoading) return;
    await getReputation(page: _currentPage + 1, userId: userId);
  }

  /// Refresh reputation history (pull to refresh)
  Future<void> refresh({required int userId}) async {
    _reputationList.clear();
    _currentPage = 1;
    _hasMore = true;
    await getReputation(page: 1, userId: userId);
  }
}
