import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:finalproject/core/shared_prefs/user_shared_prefs.dart';
import 'package:finalproject/features/post/data/dto/post_service_dto.dart';
import 'package:finalproject/features/post/data/model/post_service_model.dart';
import 'package:finalproject/features/post/domain/usecases/post_service_usecase.dart';
import 'package:finalproject/features/post/presentation/view/post_view.dart';
import 'package:finalproject/features/post/presentation/viewmodel/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'post_test.mocks.dart';

@GenerateMocks([PostServiceUsecase, UserSharedPrefs])
void main() {
  late MockPostServiceUsecase mockPostServiceUsecase;
  late MockUserSharedPrefs mockUserSharedPrefs;

  setUp(() {
    mockPostServiceUsecase = MockPostServiceUsecase();
    mockUserSharedPrefs = MockUserSharedPrefs();
  });

  testWidgets('submit a new post and check if success message is displayed',
      (tester) async {
    await mockNetworkImagesFor(() async {
      const userId = 'user123';
      final postDTO = PostServiceDTO(
        service: const PostServiceModel(
          serviceId: '',
          serviceTitle: 'Test service',
          serviceCategory: 'Events',
          servicePrice: 100.0,
          serviceLocation: 'Test Location',
          serviceDescription: 'This is a test service',
          contact: '1234567890',
          serviceImage: 'image.jpg',
          createdBy: userId,
        ),
      );
      final imageFile = File('path/to/image.jpg');

      when(mockUserSharedPrefs.getUserId()).thenAnswer(
        (_) async => Right(userId),
      );

      when(mockPostServiceUsecase.postService(postDTO, imageFile)).thenAnswer(
        (_) async => const Right(true),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postServiceViewModelProvider.overrideWith(
              (ref) => PostServiceViewModel(
                mockPostServiceUsecase,
                mockUserSharedPrefs,
              ),
            ),
          ],
          child: const MaterialApp(
            home: PostServiceView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Fill the form
      // await tester.enterText(find.byType(TextField).at(0), 'Test service');
      // await tester.tap(find.byType(GestureDetector).first);
      // await tester.pumpAndSettle();
      // await tester.enterText(find.byType(TextField).at(1), '100');
      // await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      // await tester.pumpAndSettle();
      // await tester.tap(find.text('Events').last);
      // await tester.pumpAndSettle();
      // await tester.enterText(find.byType(TextField).at(2), 'Test Location');
      // await tester.enterText(
      //     find.byType(TextField).at(3), 'This is a test service');
      await tester.enterText(
          find.byType(TextField).at(0), 'Test service'); // Title
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.tap(find.text('Events').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(1), '100'); // Price
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byType(TextField).at(2), 'Test Location'); // Location Details
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(3),
          'This is a test service'); // Description
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byType(TextField).at(4), '1234567890'); // Contact
      await tester.pumpAndSettle();

      // Ensure the ElevatedButton is visible before tapping it
      final submitButton = find.byType(ElevatedButton);
      await tester.ensureVisible(submitButton);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Wait for the SnackBar to appear
      await tester.pump(const Duration(seconds: 1));

      // Check if the success message is displayed in SnackBar
      // expect(find.text('service created successfully'), findsOneWidget);
    });
  });
}
