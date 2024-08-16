import 'package:finalproject/app/constants/api_endpoint.dart';
import 'package:finalproject/features/plan/presentation/viewmodel/plan_viewmodel.dart';
import 'package:finalproject/features/serviceDetailpage/presentation/view/service_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  ConsumerState<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends ConsumerState<FavoriteView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favoriteViewModelProvider.notifier).getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(favoriteViewModelProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 223, 223),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 227, 223, 223),
        title: const Text(
          'Bookmarked Plans',
          style: TextStyle(
            color: Colors.black, // Change this to your desired color
            fontWeight:
                FontWeight.w600, // Adjust the weight for a semi-bold appearance
          ),
        ),
        // automaticallyImplyLeading: false,
        // centerTitle: true,
        centerTitle: true,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : state.favorites.isEmpty
                  ? const Center(
                      child: Text('You have not saved any plans yet'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.favorites.length,
                      itemBuilder: (context, index) {
                        final favorite = state.favorites[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                '${ApiEndpoints.imageUrl}${favorite.serviceImage}',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              favorite.serviceTitle,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  favorite.serviceDescription,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Rs ${favorite.servicePrice}',
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ref
                                    .read(favoriteViewModelProvider.notifier)
                                    .removeFavorite(favorite.serviceId);
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServiceDetailView(
                                    serviceId: favorite.serviceId,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}
