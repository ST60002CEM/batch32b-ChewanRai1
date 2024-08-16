import 'package:finalproject/features/serviceDetailpage/domain/usecases/service_detail_usecase.dart';
import 'package:finalproject/features/serviceDetailpage/presentation/state/service_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceDetailViewModelProvider =
    StateNotifierProvider<ServiceViewmodel, ServiceDetailState>(
  (ref) => ServiceViewmodel(
    ref.read(serviceDetailUsecaseProvider),
  ),
);

class ServiceViewmodel extends StateNotifier<ServiceDetailState> {
  ServiceViewmodel(this.serviceUsecase) : super(ServiceDetailState.initial());

  final ServiceDetailUsecase serviceUsecase;

  Future<void> getPosts(String postId) async {
    state = state.copyWith(isLoading: true);

    final result = await serviceUsecase.getPosts(postId);
    print('Result: $result');

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print("Error: ${failure.error}");
      },
      (service) {
        state = state.copyWith(isLoading: false, service: service, error: null);
        print("Service loaded: ${service.serviceTitle}");
      },
    );
  }
}
