import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:finalproject/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:finalproject/features/serviceDetailpage/presentation/navigator/service_detail_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardViewNavigatorProvider =
    Provider<DashboardViewNavigator>((ref) => DashboardViewNavigator());

class DashboardViewNavigator with LoginViewRoute, ServiceViewRoute{}

mixin DashboardViewRoute {
  void openDashboardView() {
    NavigateRoute.pushRoute(const DashboardView());
  }
}
