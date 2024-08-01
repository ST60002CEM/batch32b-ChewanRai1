import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finalproject/app/constants/api_endpoint.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/core/networking/remote/http_service.dart';
import 'package:finalproject/core/shared_prefs/user_shared_prefs.dart';
import 'package:finalproject/features/profile/data/dto/profile_dto.dart';
import 'package:finalproject/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRemoteDataSourceProvider = Provider(
  (ref) => ProfileRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class ProfileRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  ProfileRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, ProfileEntity>> getUser() async {
    try {
      // Retrieve token
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(error: "Token is null", statusCode: "0"));
      }

      // Retrieve user ID
      String? id;
      var userId = await userSharedPrefs.getUserId();
      userId.fold(
        (l) => id = null,
        (r) => id = r,
      );

      if (id == null) {
        return Left(Failure(error: "User ID is null", statusCode: "0"));
      }

      // Make the API request
      var response = await dio.get(
        '${ApiEndpoints.getUser}/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Parse the response
        ProfileDTO profileDTO =
            ProfileDTO.fromJson(response.data as Map<String, dynamic>);

        if (profileDTO.userData != null) {
          return Right(profileDTO.userData!.toEntity());
        } else {
          return Left(Failure(error: "User data is null", statusCode: "0"));
        }
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> editProfile(ProfileEntity profile) async {
    try {
      // Retrieve token
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(error: "Token is null", statusCode: "0"));
      }

      // Make the API request
      var response = await dio.put(
        '${ApiEndpoints.updateuser}/${profile.userId}',
        data: {
          'fname': profile.fname,
          'lname': profile.lname,
          'phone': profile.phone,
          'email': profile.email,
          'username': profile.username,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"] ?? "Failed to update profile",
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
