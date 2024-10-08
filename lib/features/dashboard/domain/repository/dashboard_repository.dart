import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/post_failure.dart';
import 'package:finalproject/features/dashboard/data/repository/dasboard_remote_repository.dart';
import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardRepositoryProvider = Provider<IDashboardRepository>(
  (ref) => ref.read(dashboardRemoteRepositoryProvider),
);

abstract class IDashboardRepository {
  Future<Either<PostFailure, List<DashboardEntity>>> getAllPosts(int page);
  Future<Either<PostFailure, List<DashboardEntity>>> getServicesByCategory(String category, int page);
}
