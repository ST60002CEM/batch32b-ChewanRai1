import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewNavigatorProvider = Provider((ref) => HomeNavigator());

class HomeNavigator {}

mixin HomeViewRoute {
  openDashboardView() {
    NavigateRoute.pushRoute(const DashboardView());
  }
}
