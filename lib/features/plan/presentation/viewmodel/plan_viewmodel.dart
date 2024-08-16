import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/favorite_failure.dart';
import 'package:finalproject/features/plan/domain/entity/plan_entity.dart';
import 'package:finalproject/features/plan/domain/usecases/plan_usecase.dart';
import 'package:finalproject/features/plan/presentation/state/plan_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteViewModelProvider =
    StateNotifierProvider<FavoriteViewModel, FavoriteState>((ref) {
  return FavoriteViewModel(ref.read(favoriteUsecaseProvider));
});

class FavoriteViewModel extends StateNotifier<FavoriteState> {
  final FavoriteUsecase favoriteUsecase;

  FavoriteViewModel(this.favoriteUsecase) : super(FavoriteState.initial());

  Future<Either<FavoriteFailure, bool>> addFavorite(String serviceId) async {
    state = state.copyWith(isLoading: true, isFavoriteAdded: null);
    final result = await favoriteUsecase.addFavorite(serviceId);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (isSuccess) {
        state = state.copyWith(isLoading: false, isFavoriteAdded: isSuccess);
      },
    );
    return result;
  }

  Future<Either<FavoriteFailure, List<FavoriteEntity>>> getFavorites() async {
    state = state.copyWith(isLoading: true);
    final result = await favoriteUsecase.getFavorites();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (favorites) {
        state = state.copyWith(
          favorites: [...favorites],
          isLoading: false,
        );
      },
    );
    return result;
  }

  Future<void> removeFavorite(String serviceId) async {
    state = state.copyWith(isLoading: true, isFavoriteRemoved: null);
    final result = await favoriteUsecase.removeFavorite(serviceId);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (isSuccess) {
        state = state.copyWith(isLoading: false, isFavoriteRemoved: isSuccess);
        // Refresh the favorites list after removing
        getFavorites();
      },
    );
  }

  void resetState() {
    state = FavoriteState.initial();
  }
}
