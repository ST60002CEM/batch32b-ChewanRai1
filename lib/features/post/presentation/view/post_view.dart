import 'package:finalproject/features/post/data/dto/post_service_dto.dart';
import 'package:finalproject/features/post/data/model/post_service_model.dart';
import 'package:finalproject/features/post/presentation/state/post_state.dart';
import 'package:finalproject/features/post/presentation/viewmodel/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostServiceView extends ConsumerStatefulWidget {
  const PostServiceView({super.key});

  @override
  ConsumerState<PostServiceView> createState() => _PostServiceViewState();
}

class _PostServiceViewState extends ConsumerState<PostServiceView> {
  final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageNotifier.value = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    // var postServiceViewModelProvider;
    final postServiceViewModel =
        ref.read(postServiceViewModelProvider.notifier);
    final postServiceState = ref.watch(postServiceViewModelProvider);

    ref.listen<PostServiceState>(postServiceViewModelProvider,
        (previous, next) {
      if (next.isPostSuccess == true) {
        print('Showing success SnackBar');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Service created successfully')),
        );
      } else if (next.error != null) {
        print('Showing error SnackBar: ${next.error}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create service: ${next.error}')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Service',
          style: TextStyle(
            color: Colors.black, // Change this to your desired color
            fontWeight:
                FontWeight.w600, // Adjust the weight for a semi-bold appearance
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title*',
                  hintText: 'Example: Service Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Category*',
                  border: OutlineInputBorder(),
                ),
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                      value: 'Home Maintenance',
                      child: Text('Home Maintenance')),
                  DropdownMenuItem(
                      value: 'Home Modeling', child: Text('Home Modeling')),
                  DropdownMenuItem(value: 'Weddings', child: Text('Weddings')),
                  DropdownMenuItem(value: 'Events', child: Text('Events')),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price*',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location Details*',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description*',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ValueListenableBuilder<File?>(
                    valueListenable: imageNotifier,
                    builder: (context, image, child) {
                      return image == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: 50.0),
                                Text('Upload Image'),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150.0,
                              ),
                            );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final title = titleController.text;
                  final price = double.tryParse(priceController.text);
                  final location = locationController.text;
                  final description = descriptionController.text;
                  final image = imageNotifier.value;

                  if (title.isEmpty ||
                      price == null ||
                      selectedCategory == null ||
                      location.isEmpty ||
                      description.isEmpty ||
                      image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }

                  final postDTO = PostServiceDTO(
                    service: PostServiceModel(
                      serviceId: '', // will be generated by the backend
                      serviceTitle: title,
                      serviceDescription: description,
                      serviceCategory: selectedCategory!,
                      servicePrice: price,
                      serviceLocation: location,
                      serviceImage:
                          image.path, // Assuming backend handles image uploads
                      createdBy: '', // This will be updated in the ViewModel
                    ),
                  );

                  await postServiceViewModel.postService(postDTO, image);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
