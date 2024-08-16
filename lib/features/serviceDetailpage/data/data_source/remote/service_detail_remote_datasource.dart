import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finalproject/app/constants/api_endpoint.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/core/networking/remote/http_service.dart';
import 'package:finalproject/core/shared_prefs/user_shared_prefs.dart';
import 'package:finalproject/features/serviceDetailpage/data/dto/service_detail_dto.dart';
import 'package:finalproject/features/serviceDetailpage/domain/entity/service_detail_entity.dart';
import 'package:riverpod/riverpod.dart';

final serviceDetailRemoteDataSourceProvider =
    Provider<ServiceDetailRemoteDatasource>(
  (ref) => ServiceDetailRemoteDatasource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class ServiceDetailRemoteDatasource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  ServiceDetailRemoteDatasource(
      {required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, ServiceDetailEntity>> getPost(String serviceId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(statusCode: '0', error: 'Token null'));
      }
      var response = await dio.get(
        '${ApiEndpoints.getSingleService}$serviceId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Service fetched successfully');
        print('${response.data}');
        final getAllPostDto = ServiceDetailDto.fromJson(response.data);
        final posts = getAllPostDto.data.toEntity();
        return Right(posts);
      } else {
        print('Service fetching failed');
        return Left(
          Failure(error: 'Service Failed to achieved', statusCode: '0'),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}
