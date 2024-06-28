import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:finalproject/features/dashboard/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardViewNavigatorProvider =
    Provider<DashboardViewNavigator>((ref) => DashboardViewNavigator());

class DashboardViewNavigator {}

mixin DashboardViewRoute {
  void openDashboardView() {
    NavigateRoute.pushRoute(const DashboardView());
  }
}
