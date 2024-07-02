import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:finalproject/features/auth/domain/usecases/auth_usecase.dart';
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:finalproject/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
])
void main() {
  late AuthUseCase mockAuthUsecase;
  late LoginViewNavigator mockLoginViewNavigator;

  late ProviderContainer container;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
    mockLoginViewNavigator = MockLoginViewNavigator();

    TestWidgetsFlutterBinding.ensureInitialized();

    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith((ref) => AuthViewModel(
            mockLoginViewNavigator,
            mockAuthUsecase,
          ))
    ]);
  });

  test('Check for the initial state in Auth State', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  test('login test with valid email and password', () async {
    // Arrange
    const correctUsername = 'Chewan';
    const correctPassword = 'Chewan123';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          username == correctUsername && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid')));
    });

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .loginUser('Chewan', 'Chewan123');

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });
  test('register test with valid details', () async {
    //comment snack bar to pass test
    const correctFirstName = 'Chewan';
    const correctLastName = 'Rai';
    const correctPhone = '9812345678';
    const correctImage = '';
    const correctEmail = 'crai@gmail.com';
    const correctUsername = 'chewan';
    const correctPassword = '123qwe';

    AuthEntity entity = const AuthEntity(
        fname: correctFirstName,
        lname: correctLastName,
        phone: correctPhone,
        image: correctImage,
        email: correctEmail,
        username: correctUsername,
        password: correctPassword);

    when(mockAuthUsecase.registerUser(entity)).thenAnswer((invocation) {
      final entity = invocation.positionalArguments[0] as AuthEntity;

      return Future.value(entity.fname == correctFirstName &&
              entity.lname == correctLastName &&
              entity.phone == correctPhone &&
              entity.image == correctImage &&
              entity.email == correctEmail &&
              entity.username == correctUsername &&
              entity.password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    await container.read(authViewModelProvider.notifier).registerUser(
        const AuthEntity(
            fname: 'Chewan',
            lname: 'Rai',
            phone: '9812345678',
            image: '',
            email: 'crai@gmail.com',
            username: 'chewan',
            password: '123qwe'));

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });
  // test('Login test with valid username and password', body)
  //Fail test
  test('login test with invalid username and password', () async {
    //comment snack bar to pass test
    const correctPhoneNumber = '987654321';
    const correctPassword = '12345678';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final phoneNumber = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;

      return Future.value(
          phoneNumber == correctPhoneNumber && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid')));
    });

    await container
        .read(authViewModelProvider.notifier)
        .loginUser('98756789', '51764');

    final loginState = container.read(authViewModelProvider);

    expect(loginState.error, isNull);
  });
  tearDown(
    () {
      container.dispose();
    },
  );
}
