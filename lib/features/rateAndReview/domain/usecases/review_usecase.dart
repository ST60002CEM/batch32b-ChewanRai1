import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/rateAndReview/data/repository/review_repository_impl.dart';
import 'package:finalproject/features/rateAndReview/domain/entity/review_entity.dart';
import 'package:finalproject/features/rateAndReview/domain/repository/review_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createReviewUseCaseProvider = Provider(
  (ref) {
    return CreateReviewUseCase(repository: ref.read(reviewRepositoryProvider));
  },
);

final getServiceReviewsUseCaseProvider = Provider((ref) {
  return GetServiceReviewsUseCase(
      repository: ref.read(reviewRepositoryProvider));
});

class CreateReviewUseCase {
  final ReviewRepository repository;

  CreateReviewUseCase({required this.repository});

  Future<Either<Failure, bool>> call(
      String? serviceId, double? rating, String? comment) {
    return repository.createReview(serviceId!, rating!, comment!);
  }
}

class GetServiceReviewsUseCase {
  final ReviewRepository repository;

  GetServiceReviewsUseCase({required this.repository});

  Future<Either<Failure, List<ReviewEntity>>> call(String serviceId) {
    return repository.getServiceReviews(serviceId);
  }
}
