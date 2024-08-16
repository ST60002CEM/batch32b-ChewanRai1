import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/rateAndReview/domain/entity/review_entity.dart';

abstract class ReviewRepository {
  Future<Either<Failure, bool>> createReview(
      String serviceId, double rating, String comment);
  Future<Either<Failure, List<ReviewEntity>>> getServiceReviews(String serviceId);
}
