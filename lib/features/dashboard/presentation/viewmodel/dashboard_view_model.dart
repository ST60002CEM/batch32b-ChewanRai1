// import 'package:finalproject/features/dashboard/data/data_source/remote/dashboard_remote_data_source.dart';
// import 'package:finalproject/features/dashboard/presentation/navigator/dashboard_navigator.dart';
// import 'package:finalproject/features/dashboard/presentation/state/dashboard_state.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final dashboardViewModelProvider =
//     StateNotifierProvider<DashboardViewModel, DashboardState>((ref) {
//   final navigator = ref.read(dashboardViewNavigatorProvider);
//   final dashboardDataSource = ref.read(dashboardRemoteDataSourceProvider);
//   return DashboardViewModel(navigator, dashboardDataSource);
// });

// class DashboardViewModel extends StateNotifier<DashboardState> {
//   DashboardViewNavigator navigator;
//   final DashboardRemoteDataSource _postsDataSource;

//   DashboardViewModel(this.navigator, this._postsDataSource)
//       : super(DashboardState.initial()) {
//     getPosts();
//   }

//   Future resetState() async {
//     state = DashboardState.initial();
//     getPosts();
//   }

//   Future getPosts({int? page}) async {
//     state = state.copyWith(isLoading: true);
//     final currentState = state;
//     final currentPage = page ?? currentState.page + 1;
//     final posts = currentState.lstposts;
//     final hasReachedMax = currentState.hasReachedMax;
//     if (!hasReachedMax) {
//       // get data from data source
//       final result = await _postsDataSource.getAllPosts(currentPage);
//       print("result $result");
//       result.fold(
//         (failure) =>
//             state = state.copyWith(hasReachedMax: true, isLoading: false),
//         (data) {
//           if (data.isEmpty) {
//             state = state.copyWith(hasReachedMax: true);
//           } else {
//             print("data $data");
//             state = state.copyWith(
//               lstposts: [...posts, ...data],
//               page: page,
//               isLoading: false,
//             );
//           }
//         },
//       );
//     }
//   }

//   getAllPosts() {}

//   void openPostPage(String postId) {
//     navigator.openServiceDetailsView(postId);
//   }
// }
import 'package:finalproject/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:finalproject/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:finalproject/features/dashboard/presentation/state/dashboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, DashboardState>((ref) {
  final navigator = ref.read(dashboardViewNavigatorProvider);
  final dashboardUsecase = ref.read(dashboardUsecaseProvider);
  return DashboardViewModel(navigator, dashboardUsecase);
});

class DashboardViewModel extends StateNotifier<DashboardState> {
  DashboardViewNavigator navigator;
  final DashboardUsecase _dashboardUsecase;

  DashboardViewModel(this.navigator, this._dashboardUsecase)
      : super(DashboardState.initial()) {
    getPosts();
  }

  Future resetState() async {
    state = DashboardState.initial();
    getPosts();
  }

  Future getPosts({int? page}) async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final currentPage = page ?? currentState.page + 1;
    final posts = currentState.lstposts;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from usecase
      final result = await _dashboardUsecase.getAllPosts(currentPage);
      print("result $result");
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            print("data $data");
            state = state.copyWith(
              lstposts: [...posts, ...data],
              page: currentPage,
              isLoading: false,
            );
          }
        },
      );
    }
  }

  void openPostPage(String postId) {
    navigator.openServiceDetailsView(postId);
  }
}
