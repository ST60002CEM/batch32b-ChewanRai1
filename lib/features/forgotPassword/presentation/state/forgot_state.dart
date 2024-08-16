class ForgotPasswordState {
  final bool isEmailSent;
  final bool isPasswordReset;
  final bool isLoading;
  final String errorMessage;

  ForgotPasswordState({
    required this.isEmailSent,
    required this.isPasswordReset,
    required this.isLoading,
    required this.errorMessage,
  });

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      isEmailSent: false,
      isPasswordReset: false,
      isLoading: false,
      errorMessage: '',
    );
  }

  ForgotPasswordState copyWith({
    bool? isEmailSent,
    bool? isPasswordReset,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      isEmailSent: isEmailSent ?? this.isEmailSent,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
