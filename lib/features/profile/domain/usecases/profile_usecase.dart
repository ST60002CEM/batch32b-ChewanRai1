import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/profile/domain/entity/profile_entity.dart';
import 'package:finalproject/features/profile/domain/repository/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileUsecaseProvider = Provider(
  (ref) => ProfileUsecase(
    profileRepository: ref.read(profileRepositoryProvider),
  ),
);

class ProfileUsecase {
  final IProfileRepository profileRepository;

  ProfileUsecase({required this.profileRepository});

  Future<Either<Failure, ProfileEntity>> getUser() async {
    return await profileRepository.getUser();
  }

  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile) async {
    return await profileRepository.editProfile(profile);
  }
}