import 'package:finalproject/features/rateAndReview/domain/usecases/review_usecase.dart';
import 'package:finalproject/features/rateAndReview/presentation/state/review_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewViewModelProvider =
    StateNotifierProvider<ReviewViewModel, ReviewState>((ref) {
  return ReviewViewModel(
    getServiceReviewsUseCase: ref.read(getServiceReviewsUseCaseProvider),
    createReviewUseCase: ref.read(createReviewUseCaseProvider),
  );
});

class ReviewViewModel extends StateNotifier<ReviewState> {
  final GetServiceReviewsUseCase getServiceReviewsUseCase;
  final CreateReviewUseCase createReviewUseCase;

  ReviewViewModel({
    required this.getServiceReviewsUseCase,
    required this.createReviewUseCase,
  }) : super(ReviewState.initial());

  Future<void> fetchServiceReviews(String serviceId) async {
    state = state.copyWith(isLoading: true);
    print('Fetching reviews for service: $serviceId');
    final result = await getServiceReviewsUseCase(serviceId);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print('Failed to fetch reviews: ${failure.error}');
      },
      (reviews) {
        state = state.copyWith(isLoading: false, reviews: reviews);
        print('Fetched reviews: $reviews');
      },
    );
  }

  Future<void> addReview(
      String serviceId, double rating, String comment) async {
    state = state.copyWith(isLoading: true);
    print(
        'Adding review: $comment with rating: $rating for service: $serviceId');
    final result = await createReviewUseCase(serviceId, rating, comment);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print('Failed to add review: ${failure.error}');
      },
      (_) async {
        print('Review added successfully');
        await fetchServiceReviews(
            serviceId); // Re-fetch reviews after adding a new one
      },
    );
  }
}
