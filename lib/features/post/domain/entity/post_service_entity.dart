import 'package:equatable/equatable.dart';

class PostServiceEntity extends Equatable {
  final String serviceId;
  final String serviceTitle;
  final double servicePrice;
  final String serviceDescription;
  final String serviceCategory;
  final String serviceLocation;
  final String serviceImage;
  final String contact;
  final String createdBy;

  const PostServiceEntity({
    required this.serviceId,
    required this.serviceTitle,
    required this.servicePrice,
    required this.serviceDescription,
    required this.serviceCategory,
    required this.serviceLocation,
    required this.contact,
    required this.serviceImage,
    required this.createdBy
  });

  @override
  List<Object?> get props => [
        serviceTitle,
        servicePrice,
        serviceDescription,
        serviceCategory,
        serviceLocation,
        contact,
        serviceImage,
        createdBy
      ];
}
