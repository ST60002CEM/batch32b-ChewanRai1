import 'package:finalproject/features/search/presentation/viewmodel/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchViewModelProvider);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Search Services'),
      //   backgroundColor: Colors.green,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.filter_list),
      //       onPressed: () {
      //         // Handle filter action
      //       },
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearchBar(ref),
            const SizedBox(height: 10),
            _buildSearchResults(searchState),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(WidgetRef ref) {
    final searchController = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: searchController,
              onSubmitted: (value) {
                ref
                    .read(searchViewModelProvider.notifier)
                    .searchServices(value);
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search...',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(SearchState state) {
    if (state.isLoading) {
      return const CircularProgressIndicator();
    } else if (state.error.isNotEmpty) {
      return Text(state.error);
    } else if (state.services.isEmpty) {
      return const Text('No services found');
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: state.services.length,
          itemBuilder: (context, index) {
            final service = state.services[index];
            return ListTile(
              leading: Image.network(
                  'http://localhost:8000/services/${service.serviceImage}'),
              title: Text(service.serviceTitle),
              subtitle: Text('Rs ${service.servicePrice}'),
            );
          },
        ),
      );
    }
  }
}
