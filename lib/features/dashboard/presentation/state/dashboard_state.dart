import 'package:finalproject/core/common/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:finalproject/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/post_failure.dart';

class DashboardState extends StateNotifier<AsyncValue<List<DashboardEntity>>> {
  final DashboardUsecase _dashboardUsecase;

  DashboardState(this._dashboardUsecase) : super(const AsyncValue.loading());

  Future<void> fetchPosts(int page) async {
    state = const AsyncValue.loading();
    final result = await _dashboardUsecase.getAllPosts(page);
    state = result.fold(
      (failure) => AsyncValue.error(failure.message ?? 'An unknown error occurred', StackTrace.current),
      (posts) => AsyncValue.data(posts),
    );
  }
}

final dashboardStateProvider = StateNotifierProvider<DashboardState, AsyncValue<List<DashboardEntity>>>((ref) {
  final usecase = ref.watch(dashboardUsecaseProvider);
  return DashboardState(usecase);
});