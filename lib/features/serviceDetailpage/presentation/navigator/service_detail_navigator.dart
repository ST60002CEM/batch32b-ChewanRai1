import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/serviceDetailpage/presentation/view/service_detail_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceViewNavigatorProvider =
    Provider<ProfileViewNavigator>((ref) => ProfileViewNavigator());

class ProfileViewNavigator {}

mixin ServiceViewRoute {
  void openServiceDetailsView(String postId) {
    NavigateRoute.pushRoute(ServiceDetailView(serviceId: postId));
  }
}