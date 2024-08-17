import 'package:finalproject/app/constants/api_endpoint.dart';
import 'package:finalproject/features/plan/presentation/viewmodel/plan_viewmodel.dart';
import 'package:finalproject/features/rateAndReview/presentation/viewmodel/review_viewmodel.dart';
import 'package:finalproject/features/serviceDetailpage/presentation/viewmodel/service_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailView extends ConsumerStatefulWidget {
  final String serviceId;
  const ServiceDetailView({required this.serviceId, super.key});

  @override
  ConsumerState<ServiceDetailView> createState() => _ServiceDetailViewState();
}

class _ServiceDetailViewState extends ConsumerState<ServiceDetailView> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0;
  bool _isFavorite = false;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(serviceDetailViewModelProvider.notifier)
          .getPosts(widget.serviceId);
      ref
          .read(reviewViewModelProvider.notifier)
          .fetchServiceReviews(widget.serviceId);
      checkIfFavorite();
    });
  }

  void checkIfFavorite() async {
    final favoritesResult =
        await ref.read(favoriteViewModelProvider.notifier).getFavorites();
    favoritesResult.fold(
      (failure) {
        // Handle error if needed
      },
      (favoritesList) {
        setState(() {
          _isFavorite = favoritesList
              .any((favorite) => favorite.serviceId == widget.serviceId);
        });
      },
    );
  }

  // void openBookingView(BuildContext context) {
  //   final bookingView =
  //       BookingView(serviceId: widget.serviceId, quantity: _quantity);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => bookingView),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(serviceDetailViewModelProvider);
    final reviewState = ref.watch(reviewViewModelProvider);
    final post = state.service;

    if (state.isLoading || reviewState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text('Error: ${state.error}'));
    }

    if (post == null) {
      return const Center(child: Text('No post data'));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () async {
              if (_isFavorite) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Service is already in your plan')),
                );
              } else {
                final result = await ref
                    .read(favoriteViewModelProvider.notifier)
                    .addFavorite(widget.serviceId);
                result.fold(
                  (failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Service is already in in your plan')),
                    );
                  },
                  (success) {
                    setState(() {
                      _isFavorite = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Service added to your plan')),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double imageHeight = constraints.maxHeight * 0.4;
          if (constraints.maxWidth > constraints.maxHeight) {
            imageHeight = constraints.maxHeight * 0.7;
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.greenAccent,
                  child: Image.network(
                    '${ApiEndpoints.imageUrl}${post.serviceImage}',
                    width: double.infinity,
                    height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              post.serviceTitle,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'NPR ${post.servicePrice}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      // const Text(
                      //   'Description',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 8),
                      Text(
                        post.serviceDescription,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight:
                              FontWeight.w500, // This makes it a little bold
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://media.licdn.com/dms/image/v2/C4D03AQED_9C4b-TsYg/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1663845215707?e=1729123200&v=beta&t=MOSlBSBC5KMKzwtHmcLSqtEyZxj5NzRjTaAgKBNyVUY'),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   post.serviceLocation,
                              //   style: const TextStyle(
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              Text(
                                post.contact, // Use the actual contact value here
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // const SizedBox(height: 16),
                      // const Text(
                      //   'Description',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 8),
                      // Text(
                      //   post.serviceDescription,
                      //   style: const TextStyle(fontSize: 16),
                      // ),
                      // const SizedBox(height: 16),
                      // const Text(
                      //   'Category',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // Text(
                      //   post.serviceCategory,
                      //   style: const TextStyle(fontSize: 16),
                      // ),
                      const SizedBox(
                          height: 16), // Add some spacing before the button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final phoneNumber = post.contact;
                                final Uri url =
                                    Uri(scheme: 'tel', path: phoneNumber);

                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  // Handle the error gracefully
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Could not launch phone dialer')),
                                  );
                                }
                              },
                              icon:
                                  const Icon(Icons.phone, color: Colors.white),
                              label: const Text(
                                'Call Now',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .green, // Set the button color to green
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 16), // Spacing between the buttons
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                if (_isFavorite) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Service is already in your plan')),
                                  );
                                } else {
                                  final result = await ref
                                      .read(favoriteViewModelProvider.notifier)
                                      .addFavorite(widget.serviceId);
                                  result.fold(
                                    (failure) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Service is already in in your plan')),
                                      );
                                    },
                                    (success) {
                                      setState(() {
                                        _isFavorite = true;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Service added to your plan')),
                                      );
                                    },
                                  );
                                }
                              },
                              icon: const Icon(Icons.schedule,
                                  color: Colors.black), // Change color to black
                              label: const Text(
                                'Plan for Later',
                                style: TextStyle(
                                    color:
                                        Colors.black), // Change color to black
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.blue, // Set the button color to blue
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 16),
                      const SizedBox(height: 16),
                      const Text(
                        'Post Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InfoRow(label: 'Post Date', value: post.createdAt),
                      InfoRow(label: 'Location', value: post.serviceLocation),
                      const SizedBox(height: 16),
                      // const Text(
                      //   'Quantity',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 8),
                      // Row(
                      //   children: [
                      //     IconButton(
                      //       icon: const Icon(Icons.remove),
                      //       onPressed: () {
                      //         if (_quantity > 1) {
                      //           setState(() {
                      //             _quantity--;
                      //           });
                      //         }
                      //       },
                      //     ),
                      //     Text(
                      //       '$_quantity',
                      //       style: TextStyle(fontSize: 16),
                      //     ),
                      //     IconButton(
                      //       icon: const Icon(Icons.add),
                      //       onPressed: () {
                      //         setState(() {
                      //           _quantity++;
                      //         });
                      //       },
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 16),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     // ElevatedButton(
                      //     //   style: ElevatedButton.styleFrom(
                      //     //     backgroundColor: Colors.black,
                      //     //     padding: const EdgeInsets.symmetric(
                      //     //       horizontal: 32,
                      //     //       vertical: 16,
                      //     //     ),
                      //     //   ),
                      //     //   onPressed: () => openBookingView(context),
                      //     //   child: const Text('Book Now'),
                      //     // ),
                      //     ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.black,
                      //         padding: const EdgeInsets.symmetric(
                      //           horizontal: 32,
                      //           vertical: 16,
                      //         ),
                      //       ),
                      //       onPressed: () {
                      //         final cartViewModel =
                      //             ref.read(cartViewModelProvider.notifier);
                      //         cartViewModel.addServiceToCart(post.serviceId);
                      //         cartViewModel.openCartView();
                      //       },
                      //       // child: const Text('Book Now'),
                      //       child: const Text('Add To Cart'),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 16),
                      const Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (reviewState.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (reviewState.error != null)
                        Center(child: Text('Error: ${reviewState.error}'))
                      else if (reviewState.reviews.isEmpty)
                        const Center(child: Text('No reviews yet'))
                      else
                        ...reviewState.reviews.map((review) {
                          return ListTile(
                            title: Text(review.comment),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rating: ${review.rating}'),
                                Text(
                                    'User: ${review.userName}'), // Display user name
                              ],
                            ),
                          );
                        }).toList(),
                      const SizedBox(height: 16),
                      const Text(
                        'Share your experience',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(labelText: 'Comment'),
                      ),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await ref
                              .read(reviewViewModelProvider.notifier)
                              .addReview(
                                widget.serviceId,
                                _rating,
                                _commentController.text,
                              );
                        },
                        child: const Text('Submit Review',
                            selectionColor: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
