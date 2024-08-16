import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/rateAndReview/data/data_source/remote/review_remote_data_source.dart';
import 'package:finalproject/features/rateAndReview/domain/entity/review_entity.dart';
import 'package:finalproject/features/rateAndReview/domain/repository/review_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepositoryImpl(
      remoteDataSource: ref.read(reviewRemoteDataSourceProvider));
});

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> createReview(
      String serviceId, double rating, String comment) {
    return remoteDataSource.createReview(serviceId, rating, comment);
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> getServiceReviews(
      String serviceId) async {
    final result = await remoteDataSource.getServiceReviews(serviceId);
    return result.map((dtos) => dtos.map((dto) => dto.toEntity()).toList());
  }
}
