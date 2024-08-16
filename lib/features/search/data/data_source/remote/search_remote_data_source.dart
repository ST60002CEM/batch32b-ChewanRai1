// data/remote/search_remote_data_source.dart
import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:dio/dio.dart';
import 'package:finalproject/features/search/domain/entity/search_entity.dart';

class SearchRemoteDataSource {
  final Dio _dio;

  SearchRemoteDataSource(this._dio);

  Future<Either<Failure, List<SearchResult>>> searchServices(
      SearchQuery query) async {
    try {
      // Call the server's search endpoint
      final response = await _dio.post(
        'http://localhost:8000/api/service/search', // Replace with your actual server URL
        data: {'serviceTitle': query.keyword},
      );

      if (response.statusCode == 200) {
        final data = (response.data as List)
            .map((json) => SearchResult(
                  serviceTitle: json['serviceTitle'],
                  providerName: json['providerName'] ??
                      '', // Assuming provider info is included
                  price: json['servicePrice'],
                  imageUrl:
                      'http://localhost:8000/public/services/${json['serviceImage']}', // Construct image URL
                ))
            .toList();

        return Right(data);
      } else {
        return Left(Failure(error: 'Failed to fetch results'));
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
