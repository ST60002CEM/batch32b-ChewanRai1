// import 'package:finalproject/features/logout/domain/usecases/logout_usecase.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final logoutViewModelProvider = StateNotifierProvider<LogoutViewModel, AsyncValue<void>>((ref) {
//   return LogoutViewModel(ref.read(logoutUseCaseProvider));
// });

// class LogoutViewModel extends StateNotifier<AsyncValue<void>> {
//   final LogoutUseCase _logoutUseCase;

//   LogoutViewModel(this._logoutUseCase) : super(const AsyncData(null));

//   Future<void> logout() async {
//     state = const AsyncLoading();
//     final result = await _logoutUseCase.logout();
//     result.fold(
//       (failure) => state = AsyncError(failure.error),
//       (success) => state = const AsyncData(null),
//     );
//   }
// }