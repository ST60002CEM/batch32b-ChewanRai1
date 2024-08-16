import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finalproject/app/constants/api_endpoint.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/core/networking/remote/http_service.dart';
import 'package:finalproject/core/shared_prefs/user_shared_prefs.dart';
import 'package:finalproject/features/post/data/dto/post_service_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postServiceRemoteDataSourceProvider = Provider(
  (ref) => PostServiceRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class PostServiceRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  PostServiceRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> createService(PostServiceDTO postDTO, File imageFile) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(error: "Token is null", statusCode: "0"));
      }

      FormData formData = FormData.fromMap({
        'serviceTitle': postDTO.service.serviceTitle,
        'serviceDescription': postDTO.service.serviceDescription,
        'serviceCategory': postDTO.service.serviceCategory,
        'servicePrice': postDTO.service.servicePrice.toString(),
        'serviceLocation': postDTO.service.serviceLocation,
        'createdBy': postDTO.service.createdBy, // Include createdBy
        'serviceImage': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      print('FormData fields: ${formData.fields}');
      print('FormData files: ${formData.files}');

      var response = await dio.post(
        ApiEndpoints.createPost,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
