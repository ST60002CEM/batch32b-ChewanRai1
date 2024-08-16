import 'package:equatable/equatable.dart';

class ServiceDetailEntity extends Equatable {
  final String serviceId;
  final String serviceTitle;
  final int servicePrice;
  final String serviceDescription;
  final String serviceCategory;
  final String serviceLocation;
  final String contact;
  final String serviceImage;
  final String createdAt;

  const ServiceDetailEntity({
    required this.serviceId,
    required this.serviceTitle,
    required this.servicePrice,
    required this.serviceDescription,
    required this.serviceCategory,
    required this.serviceLocation,
    required this.contact,
    required this.serviceImage,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [
        serviceId,
        serviceTitle,
        servicePrice,
        serviceDescription,
        serviceCategory,
        serviceLocation,
        contact,
        serviceImage,
        createdAt,
      ];
}
