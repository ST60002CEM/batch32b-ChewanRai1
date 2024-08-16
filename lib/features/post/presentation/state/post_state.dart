

import 'package:finalproject/features/post/domain/entity/post_service_entity.dart';

class PostServiceState {
  final List<PostServiceEntity> lstServices;
  final bool isLoading;
  final String? error;
  final bool? isPostSuccess;

  PostServiceState({
    required this.lstServices,
    required this.isLoading,
    this.error,
    this.isPostSuccess,
  });

  factory PostServiceState.initial() {
    return PostServiceState(
      lstServices: [],
      isLoading: false,
      error: null,
      isPostSuccess: null,
    );
  }

  PostServiceState copyWith({
    List<PostServiceEntity>? lstServices,
    bool? isLoading,
    String? error,
    bool? isPostSuccess,
  }) {
    return PostServiceState(
      lstServices: lstServices ?? this.lstServices,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isPostSuccess: isPostSuccess ?? this.isPostSuccess,
    );
  }
}
