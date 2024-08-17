import 'package:dartz/dartz.dart';
import 'package:finalproject/app/navigator_key/navigator_key.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:finalproject/features/auth/domain/usecases/auth_usecase.dart';
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:finalproject/features/auth/presentation/view/register_view.dart';
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

  testWidgets('register a new user and check whether login view opens or not',
      (tester) async {
    const fname = 'User firstName';
    const lname = 'User lastName';
    const phone = 'User phoneNo';
    const correctEmail = 'newuser@example.com';
    const username = 'User userName';
    const correctPassword = 'newuser123';
    // const correctConfirmPassword = 'newuser123';

    when(mockAuthUsecase.registerUser(any)).thenAnswer((invocation) {
      final user = invocation.positionalArguments[0] as AuthEntity;
      return Future.value(
          user.email == correctEmail && user.password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Registration failed')));
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
          title: 'Register',
          home: const RegisterView(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), fname);
    await tester.enterText(find.byType(TextFormField).at(1), lname);
    await tester.enterText(find.byType(TextFormField).at(2), phone);
    await tester.enterText(find.byType(TextFormField).at(3), correctEmail);
    await tester.enterText(find.byType(TextFormField).at(4), username);
    await tester.enterText(find.byType(TextFormField).at(5), correctPassword);
    // await tester.enterText(
    //     find.byType(TextFormField).at(3), correctConfirmPassword);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));

    await tester.pumpAndSettle();

    // Check if the registration was successful by verifying if the LoginView is displayed
    expect(find.text('HandyHelper'), findsOneWidget);
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
          title: 'Register',
          home: const RegisterView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));

    await tester.pump();

    expect(find.text('Please enter first name'), findsOneWidget);
  });

  testWidgets('display error message when passwords do not match',
      (tester) async {
    const fname = 'User firstName';
    const lname = 'User lastName';
    const phone = 'User phoneNo';
    const correctEmail = 'newuser@example.com';
    const username = 'User userName';
    const correctPassword = 'newuser123';

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
          home: const RegisterView(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), fname);
    await tester.enterText(find.byType(TextFormField).at(1), lname);
    await tester.enterText(find.byType(TextFormField).at(2), phone);
    await tester.enterText(find.byType(TextFormField).at(3), correctEmail);
    await tester.enterText(find.byType(TextFormField).at(4), username);
    await tester.enterText(find.byType(TextFormField).at(5), correctPassword);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));

    await tester.pump();

    expect(find.text('Passwords do not match'), findsOneWidget);
  });
}
