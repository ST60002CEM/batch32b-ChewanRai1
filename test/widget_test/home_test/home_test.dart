import 'package:dartz/dartz.dart';
import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:finalproject/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:finalproject/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:finalproject/features/dashboard/presentation/view/home_view.dart';
import 'package:finalproject/features/dashboard/presentation/viewmodel/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
// import '../unit_test/unit_test.mocks.dart';
import 'home_test.mocks.dart';

@GenerateMocks([DashboardUsecase])
void main() {
  late DashboardUsecase mockDashboardUsecase;

  setUp(() {
    mockDashboardUsecase = MockDashboardUsecase();
  });

  testWidgets('load posts and check whether they are displayed or not',
      (tester) async {
    await mockNetworkImagesFor(() async {
      const page = 1;
      const dashboardEntities = [
        DashboardEntity(
          serviceId: '1',
          serviceTitle: 'service 1',
          servicePrice: 100,
          serviceDescription: 'Description 1',
          serviceCategory: 'Category 1',
          serviceLocation: 'Location 1',
          serviceImage: 'image1.jpg',
        ),
        DashboardEntity(
          serviceId: '2',
          serviceTitle: 'service 2',
          servicePrice: 200,
          serviceDescription: 'Description 2',
          serviceCategory: 'Category 2',
          serviceLocation: 'Location 2',
          serviceImage: 'image2.jpg',
        ),
      ];

      when(mockDashboardUsecase.getAllPosts(page)).thenAnswer(
        (_) => Future.value(const Right(dashboardEntities)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dashboardViewModelProvider.overrideWith(
              (ref) => DashboardViewModel(
                ref.read(dashboardViewNavigatorProvider),
                mockDashboardUsecase,
              ),
            ),
          ],
          child: const MaterialApp(
            home: HomeView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check if the posts are displayed
      expect(find.text('service 1'), findsOneWidget);
      expect(find.text('service 2'), findsOneWidget);
    });
  });

  testWidgets(
      'fetch services by category and check whether they are displayed or not',
      (tester) async {
    await mockNetworkImagesFor(() async {
      const category = 'Maintenance';
      const page = 1;
      const dashboardEntities = [
        DashboardEntity(
          serviceId: '1',
          serviceTitle: 'service 1',
          servicePrice: 100,
          serviceDescription: 'Description 1',
          serviceCategory: 'Maintenance',
          serviceLocation: 'Location 1',
          serviceImage: 'image1.jpg',
        ),
      ];

      when(mockDashboardUsecase.getServicesByCategory(category, page))
          .thenAnswer(
        (_) => Future.value(const Right(dashboardEntities)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dashboardViewModelProvider.overrideWith(
              (ref) => DashboardViewModel(
                ref.read(dashboardViewNavigatorProvider),
                mockDashboardUsecase,
              ),
            ),
          ],
          child: const MaterialApp(
            home: HomeView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Simulate tapping on a category
      await tester.tap(find.text('Art'));
      await tester.pumpAndSettle();

      // Check if the services in the selected category are displayed
      expect(find.text('service 1'), findsOneWidget);
    });
  });
}
