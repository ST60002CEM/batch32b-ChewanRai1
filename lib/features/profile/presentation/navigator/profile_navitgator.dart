import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:finalproject/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:finalproject/features/profile/presentation/view/profile_view.dart';

final profileViewNavigatorProvider = Provider((ref) => ProfileViewNavigator());

class ProfileViewNavigator with DashboardViewRoute, LoginViewRoute {}

mixin ProfileViewRoute {
  openProfileView() {
    NavigateRoute.popAndPushRoute(const ProfileView());
  }
}
