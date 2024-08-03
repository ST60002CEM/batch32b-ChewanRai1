import 'package:finalproject/features/profile/domain/entity/profile_entity.dart';
import 'package:finalproject/features/profile/domain/usecases/profile_usecase.dart';
import 'package:finalproject/features/profile/presentation/state/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>(
  (ref) => ProfileViewModel(
    ref.read(profileUsecaseProvider),
  ),
);

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel(this.profileUsecase) : super(ProfileState.initial());

  final ProfileUsecase profileUsecase;

  Future<void> fetchProfile() async {
    state = state.copyWith(isLoading: true);
    final data = await profileUsecase.getUser();
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print("Error: ${failure.error}");
      },
      (profile) {
        state = state.copyWith(isLoading: false, profile: profile, error: null);
        print("Profile loaded: ${profile.fname}");
      },
    );
  }

  Future<bool> editProfile(ProfileEntity profile) async {
    final result = await profileUsecase.updateProfile(profile);
    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.error);
        print("Error: ${failure.error}");
        return false;
      },
      (success) {
        fetchProfile(); // Refetch profile to update the state
        return true;
      },
    );
  }
}