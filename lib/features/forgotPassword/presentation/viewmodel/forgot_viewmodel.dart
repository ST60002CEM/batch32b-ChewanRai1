import 'package:finalproject/features/forgotPassword/domain/usecases/forgot_usecase.dart';
import 'package:finalproject/features/forgotPassword/presentation/state/forgot_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordViewModelProvider =
    StateNotifierProvider<ForgotPasswordViewModel, ForgotPasswordState>((ref) {
  final forgotPasswordUsecase = ref.read(forgotPasswordUsecaseProvider);
  return ForgotPasswordViewModel(forgotPasswordUsecase);
});

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  final ForgotPasswordUsecase _forgotPasswordUsecase;

  ForgotPasswordViewModel(this._forgotPasswordUsecase)
      : super(ForgotPasswordState.initial());

  Future<void> sendForgotPasswordEmail(String email) async {
    state = state.copyWith(isLoading: true);

    final result = await _forgotPasswordUsecase.sendForgotPasswordEmail(email);

    result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.error,
          isLoading: false,
        );
      },
      (success) {
        state = state.copyWith(
          isEmailSent: success,
          errorMessage: '',
          isLoading: false,
        );
      },
    );
  }

  Future<void> verifyOtpAndResetPassword(
      String email, String otp, String password) async {
    state = state.copyWith(isLoading: true);

    final result = await _forgotPasswordUsecase.verifyOtpAndResetPassword(
        email, otp, password);

    result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.error,
          isLoading: false,
        );
      },
      (success) {
        state = state.copyWith(
          isPasswordReset: success,
          errorMessage: '',
          isLoading: false,
        );
      },
    );
  }
}
