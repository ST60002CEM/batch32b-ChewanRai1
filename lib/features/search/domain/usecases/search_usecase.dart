// domain/usecase/search_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/search/domain/entity/search_entity.dart';
import 'package:finalproject/features/search/domain/repository/search_repository.dart';

class SearchUseCase {
  final ISearchRepository _searchRepository;

  SearchUseCase(this._searchRepository);

  Future<Either<Failure, List<SearchResult>>> searchServices(
      SearchQuery query) {
    return _searchRepository.searchServices(query);
  }
}
