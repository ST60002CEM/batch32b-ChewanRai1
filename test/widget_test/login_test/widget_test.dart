import 'package:dartz/dartz.dart';
import 'package:finalproject/app/navigator_key/navigator_key.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/auth/domain/usecases/auth_usecase.dart';
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:finalproject/features/auth/presentation/view/login_view.dart';
import 'package:finalproject/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../unit_test/auth_test.mocks.dart';

void main() {
  late AuthUseCase mockAuthUsecase;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
  });

  testWidgets(
      'login with email and password and check whether dashboard opens or not',
      (tester) async {
    const correctEmail = 'user@example.com';
    const correctPassword = 'user123';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email == correctEmail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              ref.read(loginViewNavigatorProvider),
              mockAuthUsecase,
            ),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Welcome to HandyHelper',
          home: const LoginView(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'user123');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    await tester.pumpAndSettle();

    expect(find.text('HandyHelper'), findsOneWidget);
  });

  testWidgets('display error message for incorrect credentials',
      (tester) async {
    const correctEmail = 'wrong@example.com';
    const correctPassword = 'wrong123';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email != correctEmail && password != correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid credentials')));
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              ref.read(loginViewNavigatorProvider),
              mockAuthUsecase,
            ),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'HandyHelper',
          home: const LoginView(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(
        find.byType(TextFormField).at(0), 'wrong@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrong123');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    await tester.pump();

    // Add a small delay to allow the SnackBar to be displayed
    await tester.pump(Duration(seconds: 1));

    expect(find.text('Invalid credentials'), findsOneWidget);
  });

  testWidgets('display error messages for empty fields on form submission',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              ref.read(loginViewNavigatorProvider),
              mockAuthUsecase,
            ),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'HandyHelper',
          home: const LoginView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    await tester.pump();

    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
}
