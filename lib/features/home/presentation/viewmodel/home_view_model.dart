import 'package:finalproject/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final dashboardViewModelProvider =
StateNotifierProvider<HomeViewModel, void>((ref) {
  final navigator = ref.read(homeViewNavigatorProvider);
  return HomeViewModel(navigator);
});

class HomeViewModel extends StateNotifier<void> {
  HomeViewModel(this.navigator) : super(null);
  HomeNavigator navigator;

}