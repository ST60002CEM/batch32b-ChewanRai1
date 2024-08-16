// domain/entity/search_query.dart
// domain/model/search_query.dart
class SearchQuery {
  final String keyword;
  final String? location;
  final String? category;

  SearchQuery({
    required this.keyword,
    this.location,
    this.category,
  });
}

// domain/model/search_result.dart
// domain/model/search_result.dart
class SearchResult {
  final String serviceTitle;
  final String providerName; // Placeholder if provider data is available
  final double price;
  final String imageUrl;

  SearchResult({
    required this.serviceTitle,
    required this.providerName,
    required this.price,
    required this.imageUrl,
  });
}
