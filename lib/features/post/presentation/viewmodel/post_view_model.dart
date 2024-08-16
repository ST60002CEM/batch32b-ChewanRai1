import 'package:finalproject/core/shared_prefs/user_shared_prefs.dart';
import 'package:finalproject/features/post/data/dto/post_service_dto.dart';
import 'package:finalproject/features/post/data/model/post_service_model.dart';
import 'package:finalproject/features/post/domain/usecases/post_service_usecase.dart';
import 'package:finalproject/features/post/presentation/state/post_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

final postServiceViewModelProvider =
    StateNotifierProvider<PostServiceViewModel, PostServiceState>((ref) {
  return PostServiceViewModel(
      ref.read(postServiceUsecaseProvider), ref.read(userSharedPrefsProvider));
});

class PostServiceViewModel extends StateNotifier<PostServiceState> {
  final PostServiceUsecase postServiceUsecase;
  final UserSharedPrefs userSharedPrefs;

  PostServiceViewModel(this.postServiceUsecase, this.userSharedPrefs)
      : super(PostServiceState.initial());

  Future<void> postService(PostServiceDTO postDTO, File imageFile) async {
    state = state.copyWith(isLoading: true, isPostSuccess: null);

    final userIdResult = await userSharedPrefs.getUserId();
    String? userId;
    userIdResult.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print('Failed to get user ID: ${failure.error}');
      },
      (id) {
        userId = id;
      },
    );

    if (userId == null) {
      state = state.copyWith(isLoading: false, error: 'User ID not found');
      print('User ID not found');
      return;
    }

    final updatedPostDTO = PostServiceDTO(
      service: PostServiceModel(
        serviceId: postDTO.service.serviceId,
        serviceTitle: postDTO.service.serviceTitle,
        serviceDescription: postDTO.service.serviceDescription,
        serviceCategory: postDTO.service.serviceCategory,
        servicePrice: postDTO.service.servicePrice,
        serviceLocation: postDTO.service.serviceLocation,
        serviceImage: postDTO.service.serviceImage,
        createdBy: userId!, // Set the user ID
      ),
    );

    final result =
        await postServiceUsecase.postService(updatedPostDTO, imageFile);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print('Failed to post service: ${failure.error}');
      },
      (isSuccess) {
        state = state.copyWith(isLoading: false, isPostSuccess: isSuccess);
        print('Service posted successfully: $isSuccess');
      },
    );
  }

  void resetState() {
    state = PostServiceState.initial();
  }
}
