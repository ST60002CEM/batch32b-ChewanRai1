import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/post/data/dto/post_service_dto.dart';
import 'package:finalproject/features/post/data/repository/post_service_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

final postServiceRepositoryProvider = Provider<IPostServiceRepository>((ref) {
  return ref.read(postRemoteRepositoryProvider);
});

abstract class IPostServiceRepository {
  Future<Either<Failure, bool>> postService(PostServiceDTO postDTO, File imageFile);
}
