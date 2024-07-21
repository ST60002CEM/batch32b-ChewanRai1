// data/repository/search_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/search/data/data_source/remote/search_remote_data_source.dart';
import 'package:finalproject/features/search/domain/entity/search_entity.dart';
import 'package:finalproject/features/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements ISearchRepository {
  final SearchRemoteDataSource _remoteDataSource;

  SearchRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<SearchResult>>> searchServices(SearchQuery query) {
    return _remoteDataSource.searchServices(query);
  }
}