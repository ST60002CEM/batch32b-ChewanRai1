import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/serviceDetailpage/domain/entity/service_detail_entity.dart';
import 'package:finalproject/features/serviceDetailpage/domain/repository/service_detail_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceDetailUsecaseProvider =
    Provider<ServiceDetailUsecase>((ref) => ServiceDetailUsecase(
          serviceDetailRepository: ref.read(serviceDetailRepositoryProvider),
        ));

class ServiceDetailUsecase {
  final IServiceDetailRepository serviceDetailRepository;

  ServiceDetailUsecase({required this.serviceDetailRepository});

  Future<Either<Failure, ServiceDetailEntity>> getPosts(String serviceId) {
    return serviceDetailRepository.getPosts(serviceId);
  }
}