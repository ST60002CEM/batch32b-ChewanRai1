import 'package:dartz/dartz.dart';
import 'package:finalproject/features/dashboard/data/data_source/remote/dashboard_remote_data_source.dart';
import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:finalproject/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:finalproject/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:finalproject/features/dashboard/presentation/viewmodel/dashboard_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'test_data/products_test_data.dart';
import 'product_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DashboardRemoteDataSource>()])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late DashboardRemoteDataSource mockProductsDataSource;
  late ProviderContainer container;
  late List<DashboardEntity> lstProducts;

  setUp(() {
    mockProductsDataSource = MockDashboardRemoteDataSource();
    // lstBatches = BatchTestData.getBatchTestData();
    lstProducts = ProductTestData().lstProducts;
    container = ProviderContainer(overrides: [
      dashboardViewModelProvider.overrideWith(
        (ref) => DashboardViewModel(
          ref.read(dashboardViewNavigatorProvider),
          MockDashboardRemoteDataSource(),
        ),
      )
    ]);
  });

  test('check for the initial state in Products state', () async {
    when(mockProductsDataSource.getAllPosts(1))
        .thenAnswer((_) => Future.value(Right(lstProducts)));

    await container.read(dashboardViewModelProvider.notifier).getAllPosts();

    final productState = container.read(dashboardViewModelProvider);

    expect(productState.isLoading, false);
    expect(productState.errorMessage, isNull);
    expect(productState.lstProducts, isNotEmpty);
  });
  test('get all products test', () async {
    // Arrange
    final userList = ProductTestData().lstProducts;
    when(mockProductsDataSource.getAllPosts(1))
        .thenAnswer((_) => Future.value(Right(userList)));

    // Act
    await container.read(dashboardViewModelProvider.notifier).getAllPosts();

    final productState = container.read(dashboardViewModelProvider);

    // Assert
    expect(productState.lstProducts, userList);
    expect(productState.errorMessage, isNull);
  });
  tearDown(() {
    container.dispose();
  });
}
