import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

final dashboardModelProvider = Provider((ref) {
  return DashboardModel.empty();
});

@JsonSerializable()
class DashboardModel {
  @JsonKey(name: '_id')
  final String serviceId;
  final String serviceTitle;
  final int servicePrice;
  final String serviceDescription;
  final String serviceCategory;
  final String serviceLocation;
  final String serviceImage;

  const DashboardModel({
    required this.serviceId,
    required this.serviceTitle,
    required this.servicePrice,
    required this.serviceDescription,
    required this.serviceCategory,
    required this.serviceLocation,
    required this.serviceImage,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      serviceId: json['_id'] ?? '',
      serviceTitle: json['serviceTitle'] ?? '',
      serviceDescription: json['serviceDescription'] ?? '',
      serviceCategory: json['serviceCategory'] ?? '',
      servicePrice: json['servicePrice'] ?? 0,
      serviceLocation: json['serviceLocation'] ?? '',
      serviceImage: json['serviceImage'] ?? '',
    );
  }

  DashboardEntity toEntity() => DashboardEntity(
      serviceId: serviceId,
      serviceTitle: serviceTitle,
      serviceDescription: serviceDescription,
      serviceCategory: serviceCategory,
      servicePrice: servicePrice,
      serviceLocation: serviceLocation,
      serviceImage: serviceImage);

  DashboardModel.empty()
      : serviceId = '',
        serviceTitle = '',
        serviceDescription = '',
        serviceCategory = '',
        servicePrice = 0,
        serviceLocation = '',
        serviceImage = '';
}
