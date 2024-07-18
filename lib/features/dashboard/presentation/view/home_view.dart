import 'package:finalproject/app/constants/api_endpoint.dart';
import 'package:finalproject/features/dashboard/presentation/state/dashboard_state.dart';
import 'package:finalproject/features/dashboard/presentation/viewmodel/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500 && !isLoading) {
      setState(() {
        isLoading = true;
      });
      _loadMorePosts();
    }
  }

  Future<void> _loadMorePosts() async {
    await ref
        .read(dashboardViewModelProvider.notifier)
        .getPosts(page: currentPage);
    print("page $currentPage");
    setState(() {
      isLoading = false;
      currentPage++;
    });
  }

  Future<void> _refreshPosts() async {
    await ref.read(dashboardViewModelProvider.notifier).resetState();
    setState(() {
      currentPage = 1;
      isLoading = false;
    });
    await _loadMorePosts();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaSize = MediaQuery.of(context).size;
    final state = ref.watch(dashboardViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.green,
          backgroundColor: Colors.amberAccent,
          onRefresh: _refreshPosts,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _searchBar(),
                  const SizedBox(
                    height: 10,
                  ),
                  _categorySection(),
                  const SizedBox(height: 10),
                  _recentPostsSection(mediaSize, state),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 205, 218, 228),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 10),
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
    );
  }

  Widget _categoryItem({required IconData icon, required String label}) {
    return Column(
      children: [
        Icon(icon, size: 30),
        Text(label),
      ],
    );
  }

  Widget _categorySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _categoryItem(icon: Icons.cleaning_services, label: 'Cleaner'),
          _categoryItem(icon: Icons.electrical_services, label: 'Electrician'),
          _categoryItem(icon: Icons.plumbing, label: 'Plumber'),
          _categoryItem(icon: Icons.format_paint, label: 'Painter'),
          _categoryItem(icon: Icons.more_horiz, label: 'More..'),
        ],
      ),
    );
  }

  Widget _recentPostsSection(Size mediaSize, DashboardState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            _scrollController.position.extentAfter == 0) {
          if (!isLoading) {
            setState(() {
              isLoading = true;
            });
            _loadMorePosts();
          }
        }
        return true;
      },
      child: SizedBox(
        height: mediaSize.height * 0.6,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: state.lstposts.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == state.lstposts.length) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.red));
            }
            final post = state.lstposts[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: mediaSize.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${ApiEndpoints.imageUrl}${post.serviceImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      post.serviceName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Rs ${post.servicePrice}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
