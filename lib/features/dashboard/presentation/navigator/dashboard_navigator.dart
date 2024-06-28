import 'package:finalproject/app/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finalproject/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:finalproject/features/dashboard/presentation/view/profile_view.dart';

// Provider for DashboardNavigator
final dashboardNavigatorProvider = Provider((ref) => DashboardNavigator());

class DashboardNavigator with DashboardViewRoute {}

mixin DashboardViewRoute {
  openDashboardView() {
    NavigateRoute.popAndPushRoute(const DashboardView());
  }
}

// mixin ProfileViewRoute {
//   void openProfileView(BuildContext context) {
//     Navigator.pushNamed(context, DashboardNavigator.profile_view);
//   }
// }