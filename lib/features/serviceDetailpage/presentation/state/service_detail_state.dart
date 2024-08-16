import 'package:finalproject/features/serviceDetailpage/domain/entity/service_detail_entity.dart';

class ServiceDetailState {
  final bool isLoading;
  final ServiceDetailEntity? service;
  final String? error;

  ServiceDetailState({
    required this.isLoading,
    this.service,
    this.error,
  });

  factory ServiceDetailState.initial() {
    return ServiceDetailState(
      isLoading: false,
      error: null,
      service: null,
    );
  }

  ServiceDetailState copyWith({
    bool? isLoading,
    final ServiceDetailEntity? service,
    String? error,
  }) {
    return ServiceDetailState(
      isLoading: isLoading ?? this.isLoading,
      service: service ?? this.service,
      error: error ?? this.error,
    );
  }

  // @override
  // String toString() => 'AuthState(isLoading: $isLoading, error: $error)';
}