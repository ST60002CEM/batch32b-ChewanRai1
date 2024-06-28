import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:finalproject/features/dashboard/presentation/state/dashboard_state.dart';
import 'package:finalproject/features/dashboard/presentation/viewmodel/dashboard_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final viewModel = ref.read(dashboardViewModelProvider);
    await viewModel.fetchPosts(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    final postsState = ref.watch(dashboardStateProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: postsState.when(
          data: (posts) => _buildPostsList(posts),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }

  Widget _buildPostsList(List<DashboardEntity> posts) {
    if (posts.isEmpty) {
      return const Center(child: Text('No posts available'));
    }
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Image.network(posts[index].productImage);
            },
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _currentPage++;
            });
            _fetchPosts();
          },
          child: const Text('Load More'),
        ),
      ],
    );
  }
}
