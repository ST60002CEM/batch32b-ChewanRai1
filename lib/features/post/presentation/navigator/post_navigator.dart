import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/post/presentation/view/post_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postServiceViewNavigatorProvider = Provider<PostServiceViewNavigator>((ref) => PostServiceViewNavigator());

class PostServiceViewNavigator {}

mixin PostServiceViewRoute {
  void openPostServiceView() {
    NavigateRoute.pushRoute(const PostServiceView());
  }
}
