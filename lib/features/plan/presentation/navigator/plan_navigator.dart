import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/plan/presentation/view/plan_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteViewNavigatorProvider =
    Provider<FavoriteViewNavigator>((ref) => FavoriteViewNavigator());

class FavoriteViewNavigator {}

mixin FavoriteViewRoute {
  void openPostView() {
    NavigateRoute.pushRoute(FavoriteView());
  }
}
