import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/post/data/data_source/remote/post_service_remote_data_source.dart';
import 'package:finalproject/features/post/data/dto/post_service_dto.dart';
import 'package:finalproject/features/post/domain/repository/post_service_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

final postRemoteRepositoryProvider = Provider<IPostServiceRepository>((ref) {
  return PostRemoteRepository(ref.read(postServiceRemoteDataSourceProvider));
});

class PostRemoteRepository implements IPostServiceRepository {
  final PostServiceRemoteDataSource _postRemoteDataSource;

  PostRemoteRepository(this._postRemoteDataSource);

  @override
  Future<Either<Failure, bool>> postService(PostServiceDTO postDTO, File imageFile) {
    return _postRemoteDataSource.createService(postDTO, imageFile);
  }
}
