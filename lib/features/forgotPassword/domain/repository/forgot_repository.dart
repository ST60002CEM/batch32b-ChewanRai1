import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/forgot_failure.dart';
import 'package:finalproject/features/forgotPassword/data/repository/forgot_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordProvider = Provider<IForgotPasswordRepository>(
  (ref) => ref.read(forgotPasswordRepositoryProvider),
);

abstract class IForgotPasswordRepository {
  Future<Either<ForgotPasswordFailure, bool>> sendForgotPasswordEmail(String email);
  Future<Either<ForgotPasswordFailure, bool>> verifyOtpAndResetPassword(String email, String otp, String password);
}
