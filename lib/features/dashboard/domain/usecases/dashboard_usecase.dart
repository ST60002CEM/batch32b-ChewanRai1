import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finalproject/core/failure/post_failure.dart';
import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:finalproject/features/dashboard/domain/repository/dashboard_repository.dart';

// Provider for DashboardUsecase
final dashboardUsecaseProvider = Provider<DashboardUsecase>((ref) => DashboardUsecase(
      dashboardRepository: ref.read(dashboardRepositoryProvider),
    ));

class DashboardUsecase {
  final IDashboardRepository dashboardRepository;

  DashboardUsecase({required this.dashboardRepository});

  Future<Either<PostFailure, List<DashboardEntity>>> getAllPosts(int page) {
    return dashboardRepository.getAllPosts(page);
  }

  Future<Either<PostFailure, List<DashboardEntity>>> getServicesByCategory(
      String category, int page) {
    return dashboardRepository.getServicesByCategory(category, page);
  }
}