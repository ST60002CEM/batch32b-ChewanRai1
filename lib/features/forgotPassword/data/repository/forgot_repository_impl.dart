import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/forgot_failure.dart';
import 'package:finalproject/features/forgotPassword/data/data_source/remote/forgot_remote_data_source.dart';
import 'package:finalproject/features/forgotPassword/domain/repository/forgot_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordRepositoryProvider = Provider<IForgotPasswordRepository>(
  (ref) => ForgotPasswordRepository(
    forgotPasswordRemoteDataSource:
        ref.read(forgotPasswordRemoteDataSourceProvider),
  ),
);

class ForgotPasswordRepository implements IForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource forgotPasswordRemoteDataSource;

  ForgotPasswordRepository({required this.forgotPasswordRemoteDataSource});

  @override
  Future<Either<ForgotPasswordFailure, bool>> sendForgotPasswordEmail(
      String email) {
    return forgotPasswordRemoteDataSource.sendForgotPasswordEmail(email);
  }

  @override
  Future<Either<ForgotPasswordFailure, bool>> verifyOtpAndResetPassword(
      String email, String otp, String password) {
    return forgotPasswordRemoteDataSource.verifyOtpAndResetPassword(
        email, otp, password);
  }
}
