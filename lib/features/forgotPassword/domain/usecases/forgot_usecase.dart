import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/forgot_failure.dart';
import 'package:finalproject/features/forgotPassword/data/repository/forgot_repository_impl.dart';
import 'package:finalproject/features/forgotPassword/domain/repository/forgot_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordUsecaseProvider = Provider<ForgotPasswordUsecase>((ref) => ForgotPasswordUsecase(
  forgotPasswordRepository: ref.read(forgotPasswordRepositoryProvider),
));

class ForgotPasswordUsecase {
  final IForgotPasswordRepository forgotPasswordRepository;

  ForgotPasswordUsecase({required this.forgotPasswordRepository});

  Future<Either<ForgotPasswordFailure, bool>> sendForgotPasswordEmail(String email) {
    return forgotPasswordRepository.sendForgotPasswordEmail(email);
  }

  Future<Either<ForgotPasswordFailure, bool>> verifyOtpAndResetPassword(String email, String otp, String password) {
    return forgotPasswordRepository.verifyOtpAndResetPassword(email, otp, password);
  }
}
