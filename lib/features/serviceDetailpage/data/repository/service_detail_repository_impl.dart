import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/serviceDetailpage/data/data_source/remote/service_detail_remote_datasource.dart';
import 'package:finalproject/features/serviceDetailpage/domain/entity/service_detail_entity.dart';
import 'package:finalproject/features/serviceDetailpage/domain/repository/service_detail_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceDetailRemoteRepositoryProvider = Provider<IServiceDetailRepository>(
  (ref) => ServiceDetailRemoteRepository(
      serviceRemoteDataSource: ref.read(serviceDetailRemoteDataSourceProvider)),
);

class ServiceDetailRemoteRepository implements IServiceDetailRepository {
  final ServiceDetailRemoteDatasource serviceRemoteDataSource;

  ServiceDetailRemoteRepository({required this.serviceRemoteDataSource});

  @override
  Future<Either<Failure, ServiceDetailEntity>> getPosts(String serviceId) {
    return serviceRemoteDataSource.getPost(serviceId);
  }
}