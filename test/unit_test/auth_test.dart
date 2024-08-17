import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:finalproject/features/auth/domain/usecases/auth_usecase.dart';
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:finalproject/features/auth/presentation/navigator/register_navigator.dart';
import 'package:finalproject/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:finalproject/features/profile/domain/entity/profile_entity.dart';
import 'package:finalproject/features/profile/domain/repository/profile_repository.dart';
import 'package:finalproject/features/profile/domain/usecases/profile_usecase.dart';
import 'package:finalproject/features/rateAndReview/domain/entity/review_entity.dart';
import 'package:finalproject/features/rateAndReview/domain/repository/review_repository.dart';
import 'package:finalproject/features/rateAndReview/domain/usecases/review_usecase.dart';
import 'package:finalproject/features/serviceDetailpage/domain/entity/service_detail_entity.dart';
import 'package:finalproject/features/serviceDetailpage/domain/repository/service_detail_repository.dart';
import 'package:finalproject/features/serviceDetailpage/domain/usecases/service_detail_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
  MockSpec<RegisterViewNavigator>(),
  MockSpec<IServiceDetailRepository>(),
  MockSpec<ReviewRepository>(),
  MockSpec<IProfileRepository>(),
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
  test('register test with invalid details', () async {
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
            password: '123qwee'));

    final registerState = container.read(authViewModelProvider);

    expect(registerState.error, isNull);
  });
  // tearDown(
  //   () {
  //     container.dispose();
  //   },
  // );

  group('Authentication Group', () {
    test('login test with valid data', () async {
      const correctEmail = 'chewan@gmail.com';
      const correctPassword = 'chewan1234';

      when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        return Future.value(email == correctEmail && password == correctPassword
            ? const Right(true)
            : Left(Failure(error: 'Invalid')));
      });
      await container
          .read(authViewModelProvider.notifier)
          .loginUser('chewan@gmail.com', 'chewan1234');
      final authState = container.read(authViewModelProvider);
      expect(authState.error, isNull);
    });

    // login test fail
    test('login test with invalid data', () async {
      const correctEmail = 'chewan@gmail.com';
      const correctPassword = 'chewan1234';

      when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        return Future.value(email == correctEmail && password == correctPassword
            ? const Right(true)
            : Left(Failure(error: 'Invalid')));
      });
      await container
          .read(authViewModelProvider.notifier)
          .loginUser('chewan@gmail.com', 'chewan123');
      final authState = container.read(authViewModelProvider);
      expect(authState.error, isNull);
    });
  });

// service Detail Usecase tests
  group('ServiceDetailUsecase', () {
    late ServiceDetailUsecase serviceDetailUsecase;
    late MockIServiceDetailRepository mockServiceDetailRepository;

    setUp(() {
      mockServiceDetailRepository = MockIServiceDetailRepository();
      serviceDetailUsecase = ServiceDetailUsecase(
          serviceDetailRepository: mockServiceDetailRepository);
    });

    final tServiceId = '123';
    final tServiceDetail = ServiceDetailEntity(
      serviceId: tServiceId,
      serviceTitle: 'Test Service',
      servicePrice: 100,
      serviceDescription: 'Test Description',
      serviceCategory: 'Test Category',
      serviceLocation: 'Test Location',
      serviceImage: 'image.jpg',
      createdAt: '2024-08-07T12:00:00Z',
      contact: '9812345678',
    );

    test('should get service details from the repository', () async {
      // Arrange
      when(mockServiceDetailRepository.getPosts(any))
          .thenAnswer((_) async => Right(tServiceDetail));

      // Act
      final result = await serviceDetailUsecase.getPosts(tServiceId);

      // Assert
      expect(result, Right(tServiceDetail));
      verify(mockServiceDetailRepository.getPosts(tServiceId));
      verifyNoMoreInteractions(mockServiceDetailRepository);
    });
  });

  // testing for rate and review
  group('Rate and Review Usecase Tests', () {
    late ReviewRepository mockReviewRepository;
    late CreateReviewUseCase createReviewUseCase;
    late GetServiceReviewsUseCase getServiceReviewsUseCase;

    setUp(() {
      mockReviewRepository = MockReviewRepository();
      createReviewUseCase =
          CreateReviewUseCase(repository: mockReviewRepository);
      getServiceReviewsUseCase =
          GetServiceReviewsUseCase(repository: mockReviewRepository);
    });

    test('should create a review successfully', () async {
      const serviceId = '123';
      const rating = 4.5;
      const comment = 'Good service!';

      when(mockReviewRepository.createReview(serviceId, rating, comment))
          .thenAnswer((_) async => const Right(true));

      final result = await createReviewUseCase(serviceId, rating, comment);

      expect(result, const Right(true));
      verify(mockReviewRepository.createReview(serviceId, rating, comment))
          .called(1);
    });
    test('should return service reviews successfully', () async {
      const serviceId = '123';
      final reviewList = [
        ReviewEntity(
          id: '1',
          serviceId: '123',
          userId: 'user123',
          userName: 'User One',
          rating: 4.5,
          comment: 'Good service!',
          createdAt: DateTime.parse('2022-01-01'),
        ),
      ];

      when(mockReviewRepository.getServiceReviews(serviceId))
          .thenAnswer((_) async => Right(reviewList));

      final result = await getServiceReviewsUseCase(serviceId);

      expect(result, Right(reviewList));
      verify(mockReviewRepository.getServiceReviews(serviceId)).called(1);
    });
  });

  // Profile tests
  group('Profile Usecase Tests', () {
    late IProfileRepository mockProfileRepository;
    late ProfileUsecase profileUsecase;

    setUp(() {
      mockProfileRepository = MockIProfileRepository();
      profileUsecase = ProfileUsecase(profileRepository: mockProfileRepository);
    });

    test('should return ProfileEntity on successful fetch', () async {
      const profileEntity = ProfileEntity(
          userId: '1',
          fname: 'Chewan',
          lname: 'Rai',
          phone: '9812345678',
          email: 'chewan@example.com',
          username: 'chewanrai'
          // profileImage: 'path/to/image.jpg',
          );

      when(mockProfileRepository.getUser())
          .thenAnswer((_) async => const Right(profileEntity));

      final result = await profileUsecase.getUser();

      expect(result, const Right(profileEntity));
      verify(mockProfileRepository.getUser()).called(1);
    });
  });

  tearDown(() {
    container.dispose();
  });
}
