import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/favorite_failure.dart';
import 'package:finalproject/features/plan/domain/entity/plan_entity.dart';

abstract class IFavoriteRepository {
  Future<Either<FavoriteFailure, bool>> addFavorite(String serviceId);
  Future<Either<FavoriteFailure, List<FavoriteEntity>>> getFavorites();
  Future<Either<FavoriteFailure, bool>> removeFavorite(String serviceId);
}
