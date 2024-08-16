import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/favorite_failure.dart';
import 'package:finalproject/features/plan/data/data_source/remote/plan_data_source.dart';
import 'package:finalproject/features/plan/domain/entity/plan_entity.dart';
import 'package:finalproject/features/plan/domain/repository/plan_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteRepositoryProvider = Provider<IFavoriteRepository>((ref) {
  return FavoriteRepository(ref.read(favoriteRemoteDataSourceProvider));
});

class FavoriteRepository implements IFavoriteRepository {
  final FavoriteRemoteDataSource _favoriteRemoteDataSource;

  FavoriteRepository(this._favoriteRemoteDataSource);

  @override
  Future<Either<FavoriteFailure, bool>> addFavorite(String serviceId) {
    return _favoriteRemoteDataSource.addFavorite(serviceId);
  }

  @override
  Future<Either<FavoriteFailure, List<FavoriteEntity>>> getFavorites() {
    return _favoriteRemoteDataSource.getFavorites();
  }

  @override
  Future<Either<FavoriteFailure, bool>> removeFavorite(String serviceId) {
    return _favoriteRemoteDataSource.removeFavorite(serviceId);
  }
}
