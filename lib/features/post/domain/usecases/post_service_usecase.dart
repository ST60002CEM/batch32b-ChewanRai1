import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/post/data/dto/post_service_dto.dart';
import 'package:finalproject/features/post/domain/repository/post_service_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

final postServiceUsecaseProvider = Provider(
  (ref) => PostServiceUsecase(
    postServiceRepository: ref.read(postServiceRepositoryProvider),
  ),
);

class PostServiceUsecase {
  final IPostServiceRepository postServiceRepository;

  PostServiceUsecase({required this.postServiceRepository});

  Future<Either<Failure, bool>> postService(PostServiceDTO postDTO, File imageFile) async {
    return postServiceRepository.postService(postDTO, imageFile);
  }
}
