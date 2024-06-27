import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finalproject/app/constants/api_endpoint.dart';
import 'package:finalproject/core/failure/post_failure.dart';
import 'package:finalproject/core/networking/remote/http_service.dart';
import 'package:finalproject/features/dashboard/data/dto/dashboard_dto.dart';
import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardRemoteDataSourceProvider =
    Provider<DashboardRemoteDataSource>((ref) {
  final dio = ref.read(httpServiceProvider);
  return DashboardRemoteDataSource(dio);
});

class DashboardRemoteDataSource {
  final Dio _dio;
  DashboardRemoteDataSource(this._dio);
  Future<Either<PostFailure, List<DashboardEntity>>> getAllPosts(
      int page) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.pagination,
        queryParameters: {
          '_page': page,
          '_limit': ApiEndpoints.limitPage,
        },
      );
      // final data = response.data as List;
      if (response.statusCode == 201) {
        final getAllPostDto = DashboardDto.fromJson(response.data);
        final posts = getAllPostDto.data.map((e) => e.toEntity()).toList();
        return Right(posts);
      } else {
        return const Left(
          PostFailure(
            message: 'Post Failed to achieved',
          ),
        );
      }
      // final posts = data.map((e) => Posts.fromJson(e)).toList();
      // return Right(posts);
    } on DioException catch (e) {
      return Left(PostFailure(message: e.message.toString()));
    }
  }
}
