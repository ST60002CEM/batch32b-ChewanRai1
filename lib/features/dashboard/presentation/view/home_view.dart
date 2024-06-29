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
  void dispose() {
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

  final List<String> images = [
    'assets/images/upkeep.jpeg',
    'assets/images/energy.jpeg',
  ];
  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    Size mediaSize = MediaQuery.of(context).size;
    final state = ref.watch(dashboardViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topBar(),
                _searchBar(),
                const SizedBox(
                  height: 10,
                ),
                _homeSlider(mediaSize),
                _categorySection(),
                const SizedBox(height: 10),
                _recentPostsSection(mediaSize, state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.category),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.message),
        )
      ],
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

  Widget _homeSlider(Size mediaSize) {
    return Stack(
      children: [
        SizedBox(
          height: mediaSize.height * 0.20,
          width: mediaSize.width,
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentSlide = value;
              });
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: currentSlide == index ? 15 : 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentSlide == index
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _categoryItem(icon: Icons.mobile_friendly, label: 'Mobile'),
          _categoryItem(icon: Icons.computer, label: 'Computer'),
          _categoryItem(icon: Icons.house, label: 'Real Estate'),
          _categoryItem(icon: Icons.airport_shuttle, label: 'Vechiles'),
        ],
      ),
    );
  }

  Widget _recentPostsSection(Size mediaSize, DashboardState state) {
    return NotificationListener(
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
        child: GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: state.lstposts.length,
          itemBuilder: (context, index) {
            final post = state.lstposts[index];
            return Container(
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
                  Expanded(
                    child: Container(
                      height: mediaSize.height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${ApiEndpoints.imageUrl}${post.productImage}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Positioned(
                          //   top: 10,
                          //   right: 10,
                          //   child: CircleAvatar(
                          //     backgroundColor: Colors.white,
                          //     // child: IconButton(
                          //     //   icon: const Icon(Icons.favorite_border,
                          //     //       color: Colors.red),
                          //     //   onPressed: () {},
                          //     // ),
                          //     // child: Text(post.condition),
                          //   ),
                          // ),
                          // Positioned(
                          //   top: 10,
                          //   left: 10,
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 8, vertical: 4),
                          //     decoration: BoxDecoration(
                          //       color: Colors.green,
                          //       borderRadius: BorderRadius.circular(20),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      post.productName,
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
                      'Rs ${post.productPrice}',
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
