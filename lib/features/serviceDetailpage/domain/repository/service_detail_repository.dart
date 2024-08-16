import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/serviceDetailpage/data/repository/service_detail_repository_impl.dart';
import 'package:finalproject/features/serviceDetailpage/domain/entity/service_detail_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceDetailRepositoryProvider = Provider<IServiceDetailRepository>(
  (ref) => ref.read(serviceDetailRemoteRepositoryProvider),
);

abstract class IServiceDetailRepository {
  Future<Either<Failure, ServiceDetailEntity>> getPosts(String serviceId);
}