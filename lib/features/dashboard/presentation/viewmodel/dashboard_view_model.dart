import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finalproject/features/dashboard/presentation/state/dashboard_state.dart';

class DashboardViewModel {
  final Ref _ref;

  DashboardViewModel(this._ref);

  Future<void> fetchPosts(int page) async {
    await _ref.read(dashboardStateProvider.notifier).fetchPosts(page);
  }
}

final dashboardViewModelProvider = Provider((ref) {
  return DashboardViewModel(ref);
});
