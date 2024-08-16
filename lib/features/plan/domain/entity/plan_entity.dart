import 'package:equatable/equatable.dart';

class FavoriteEntity extends Equatable {
  final String serviceId;
  final String serviceTitle;
  final int servicePrice;
  final String serviceDescription;
  final String serviceCategory;
  final String serviceLocation;
  final String serviceImage;

  const FavoriteEntity({
    required this.serviceId,
    required this.serviceTitle,
    required this.servicePrice,
    required this.serviceDescription,
    required this.serviceCategory,
    required this.serviceLocation,
    required this.serviceImage,
  });

  @override
  List<Object?> get props => [
        serviceId,
        serviceTitle,
        servicePrice,
        serviceDescription,
        serviceCategory,
        serviceLocation,
        serviceImage,
      ];
}
