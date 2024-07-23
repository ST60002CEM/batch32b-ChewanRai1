// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:finalproject/core/failure/failure.dart';
// import 'package:finalproject/core/networking/remote/http_service.dart';
// import 'package:finalproject/core/shared_prefs/user_shared_prefs.dart';
// import 'package:dio/dio.dart';

// final logoutUseCaseProvider = Provider((ref) {
//   return LogoutUseCase(
//     dio: ref.read(httpServiceProvider),
//     userSharedPrefs: ref.read(userSharedPrefsProvider),
//   );
// });

// class LogoutUseCase {
//   final Dio dio;
//   final UserSharedPrefs userSharedPrefs;

//   LogoutUseCase({required this.dio, required this.userSharedPrefs});

//   Future<Either<Failure, bool>> logout() async {
//     try {
//       // Get the token
//       final tokenResult = await userSharedPrefs.getUserToken();
//       String? token;

//       tokenResult.fold(
//         (l) => null,
//         (r) => token = r,
//       );

//       if (token == null) {
//         return Left(Failure(error: 'No token found'));
//       }

//       // Call logout API
//       final response = await dio.post(
//         '/logout', // Your logout endpoint
//         options: Options(
//           headers: {'Authorization': 'Bearer $token'},
//         ),
//       );

//       if (response.statusCode == 200) {
//         // Clear the token locally
//         await userSharedPrefs.deleteUserToken();
//         return const Right(true);
//       } else {
//         return Left(Failure(error: 'Failed to logout'));
//       }
//     } on DioException catch (e) {
//       return Left(Failure(error: e.message));
//     }
//   }
// }