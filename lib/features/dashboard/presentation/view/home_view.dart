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
  int currentPage = 0;

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

  final List<String> images = [
    'assets/images/s1.jpg',
    'assets/images/s2.jpg',
    'assets/images/s3.jpg',
    'assets/images/s4.jpg',
    'assets/images/s5.jpeg',
    'assets/images/s6.jpeg',
  ];
  int currentSlide = 0;

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
                  const SizedBox(height: 10),
                  _homeSlider(mediaSize), // Add the slider here
                  const SizedBox(height: 20),
                  _categorySection(),
                  const SizedBox(height: 10),
                  const Text(
                    "All Services",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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

  Widget _homeSlider(Size mediaSize) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double sliderHeight = constraints.maxHeight * 0.2;
        if (sliderHeight > 250) sliderHeight = 250;
        return Stack(
          children: [
            SizedBox(
              height: sliderHeight,
              width: constraints.maxWidth,
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                        ),
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
                        color:
                            currentSlide == index ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
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
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _categoryItem(icon: Icons.construction, label: 'Maintenance'),
          _categoryItem(icon: Icons.event, label: 'Events'),
          _categoryItem(icon: Icons.architecture, label: 'Modeling'),
          _categoryItem(icon: Icons.celebration, label: 'Weddings'),

          // _categoryItem(icon: Icons.more_horiz, label: 'More..'),
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
        height: mediaSize.height * 0.35, // Reduced the height slightly
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
            return GestureDetector(
              onTap: () {
                // Open the service details page
                ref
                    .read(dashboardViewModelProvider.notifier)
                    .openPostPage(post.serviceId);
              },
              child: Container(
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
                      height:
                          mediaSize.height * 0.2, // Reduced the height slightly
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
                        post.serviceTitle,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
