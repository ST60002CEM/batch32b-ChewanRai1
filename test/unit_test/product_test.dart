

// import 'package:dartz/dartz.dart';
// import 'package:finalproject/features/dashboard/data/data_source/remote/dashboard_remote_data_source.dart';
// import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
// import 'package:finalproject/features/dashboard/presentation/navigator/dashboard_navigator.dart';
// import 'package:finalproject/features/dashboard/presentation/viewmodel/dashboard_view_model.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'product_test.mocks.dart';
// import 'test_data/products_test_data.dart';

// @GenerateNiceMocks([MockSpec<DashboardRemoteDataSource>()])
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   late DashboardRemoteDataSource mockServicesDataSource;
//   late ProviderContainer container;
//   late List<DashboardEntity> lstServices;

//   setUp(() {
//     mockServicesDataSource = MockDashboardRemoteDataSource();
//     // lstBatches = BatchTestData.getBatchTestData();
//     lstServices = ServiceTestData().lstServices;
//     container = ProviderContainer(overrides: [
//       dashboardViewModelProvider.overrideWith(
//         (ref) => DashboardViewModel(
//           ref.read(dashboardViewNavigatorProvider),
//           MockDashboardRemoteDataSource(),
//         ),
//       )
//     ]);
//   });

//   test('check for the initial state in Services state', () async {
//     when(mockServicesDataSource.getAllPosts(1))
//         .thenAnswer((_) => Future.value(Right(lstServices)));

//     await container.read(dashboardViewModelProvider.notifier).getAllPosts();

//     final serviceState = container.read(dashboardViewModelProvider);

//     expect(serviceState.isLoading, false);
//     expect(serviceState.errorMessage, isNull);
//     expect(serviceState.lstServices, isNotEmpty);
//   });
//   test('get all services test', () async {
//     // Arrange
//     final userList = ServiceTestData().lstServices;
//     when(mockServicesDataSource.getAllPosts(1))
//         .thenAnswer((_) => Future.value(Right(userList)));

//     // Act
//     await container.read(dashboardViewModelProvider.notifier).getAllPosts();

//     final serviceState = container.read(dashboardViewModelProvider);

//     // Assert
//     expect(serviceState.lstServices, userList);
//     expect(serviceState.errorMessage, isNull);
//   });
//   tearDown(() {
//     container.dispose();
//   });
// }
