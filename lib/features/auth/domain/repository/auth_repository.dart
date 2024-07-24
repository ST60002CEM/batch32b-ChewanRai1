import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:finalproject/core/common/provider/internet_checker.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/auth/data/repository/auth_local_repository.dart';
import 'package:finalproject/features/auth/data/repository/auth_remote_repository.dart';
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  // return ref.read(authRemoteRepositoryProvider);
  final checkConnectivity = ref.read(connectivityStatusProvider);

  if (checkConnectivity == ConnectivityStatus.isConnected) {
    return ref.read(authRemoteRepositoryProvider);
  } else {
    //not works just to ignore error for logoutuser remotely
    // return ref.read(authLocalRepositoryProvider);

    //working purely on remote.
    return ref.read(authRemoteRepositoryProvider);
  }
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(AuthEntity user);
  Future<Either<Failure, bool>> loginUser(String email, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, bool>> logoutUser();
}
