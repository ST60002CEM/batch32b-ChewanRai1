// domain/repository/search_repository.dart
import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/search/domain/entity/search_entity.dart';

abstract class ISearchRepository {
  Future<Either<Failure, List<SearchResult>>> searchServices(SearchQuery query);
}