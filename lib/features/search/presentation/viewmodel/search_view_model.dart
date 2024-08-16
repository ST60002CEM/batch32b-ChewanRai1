// // presentation/viewmodel/search_view_model.dart
// import 'package:finalproject/core/common/provider/providers.dart';
// import 'package:finalproject/features/search/domain/entity/search_entity.dart';
// import 'package:finalproject/features/search/domain/usecases/search_usecase.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:finalproject/core/failure/failure.dart';

// final searchViewModelProvider =
//     StateNotifierProvider<SearchViewModel, List<SearchResult>>((ref) {
//   final searchUseCase = ref.read(searchUseCaseProvider);
//   return SearchViewModel(searchUseCase);
// });

// class SearchViewModel extends StateNotifier<List<SearchResult>> {
//   final SearchUseCase _searchUseCase;

//   SearchViewModel(this._searchUseCase) : super([]);

//   Future<void> searchServices(SearchQuery query) async {
//     final result = await _searchUseCase.searchServices(query);

//     result.fold(
//       (failure) {
//         // Handle error
//         state = [];
//       },
//       (searchResults) {
//         state = searchResults;
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

// Define the service model based on your API response
class ServiceModel {
  final String id;
  final String serviceTitle;
  final double servicePrice;
  final String serviceDescription;
  final String serviceCategory;
  final String serviceLocation;
  final String serviceImage;

  ServiceModel({
    required this.id,
    required this.serviceTitle,
    required this.servicePrice,
    required this.serviceDescription,
    required this.serviceCategory,
    required this.serviceLocation,
    required this.serviceImage,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'],
      serviceTitle: json['serviceTitle'],
      servicePrice: json['servicePrice'].toDouble(),
      serviceDescription: json['serviceDescription'],
      serviceCategory: json['serviceCategory'],
      serviceLocation: json['serviceLocation'],
      serviceImage: json['serviceImage'],
    );
  }
}

// Define the state for the search view
class SearchState {
  final bool isLoading;
  final List<ServiceModel> services;
  final String error;

  SearchState({
    this.isLoading = false,
    this.services = const [],
    this.error = '',
  });
}

// Create the SearchViewModelProvider
class SearchViewModel extends StateNotifier<SearchState> {
  SearchViewModel() : super(SearchState());

  final Dio _dio = Dio();

  Future<void> searchServices(String serviceTitle) async {
    state = SearchState(isLoading: true);

    try {
      final response = await _dio.post(
        'http://localhost:8000/api/service/search',
        data: {'serviceTitle': serviceTitle},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final services = data.map((json) => ServiceModel.fromJson(json)).toList();
        state = SearchState(services: services);
      } else {
        state = SearchState(error: 'Failed to load services');
      }
    } catch (error) {
      state = SearchState(error: 'An error occurred: $error');
    }
  }
}

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>(
        (ref) => SearchViewModel());