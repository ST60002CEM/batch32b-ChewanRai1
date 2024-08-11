import 'package:equatable/equatable.dart';

class DashboardEntity extends Equatable {
  final String serviceId;
  final String serviceName;
  final int servicePrice;
  final String serviceDescription;
  final String serviceCategory;
  final String serviceLocation;
  final String serviceImage;

  const DashboardEntity({
    required this.serviceId,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceDescription,
    required this.serviceCategory,
    required this.serviceLocation,
    required this.serviceImage,
  });
  @override
  List<Object?> get props => [
        serviceId,
        serviceName,
        servicePrice,
        serviceDescription,
        serviceCategory,
        serviceLocation,
        serviceImage
      ];
}
