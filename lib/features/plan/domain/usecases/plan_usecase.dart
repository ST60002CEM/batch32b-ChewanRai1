import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/favorite_failure.dart';
import 'package:finalproject/features/plan/data/repository/plan_repository_impl.dart';
import 'package:finalproject/features/plan/domain/entity/plan_entity.dart';
import 'package:finalproject/features/plan/domain/repository/plan_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteUsecaseProvider = Provider(
  (ref) => FavoriteUsecase(
    favoriteRepository: ref.read(favoriteRepositoryProvider),
  ),
);

class FavoriteUsecase {
  final IFavoriteRepository favoriteRepository;

  FavoriteUsecase({required this.favoriteRepository});

  Future<Either<FavoriteFailure, bool>> addFavorite(String serviceId) async {
    return favoriteRepository.addFavorite(serviceId);
  }

  Future<Either<FavoriteFailure, List<FavoriteEntity>>> getFavorites() async {
    return await favoriteRepository.getFavorites();
  }

  Future<Either<FavoriteFailure, bool>> removeFavorite(String serviceId) async {
    return favoriteRepository.removeFavorite(serviceId);
  }
}
