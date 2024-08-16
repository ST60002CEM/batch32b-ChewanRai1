import 'package:finalproject/features/serviceDetailpage/domain/entity/service_detail_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

final serviceDetailModelProvider = Provider((ref) {
  return ServiceDetailModel.empty();
});

@JsonSerializable()
class ServiceDetailModel {
  @JsonKey(name: '_id')
  final String serviceId;
  final String serviceTitle;
  final int servicePrice;
  final String serviceDescription;
  final String serviceCategory;
  final String serviceLocation;
  final String serviceImage;
  final String createdAt;

  ServiceDetailModel({
    required this.serviceId,
    required this.serviceTitle,
    required this.servicePrice,
    required this.serviceDescription,
    required this.serviceCategory,
    required this.serviceLocation,
    required this.serviceImage,
    required this.createdAt,
  });

  factory ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    print('Received JSON: $json'); // Add this line to log the incoming JSON
    return ServiceDetailModel(
      serviceId: json['_id'] ?? '',
      serviceTitle: json['serviceTitle'] ?? '',
      serviceDescription: json['serviceDescription'] ?? '',
      serviceCategory: json['serviceCategory'] ?? '',
      servicePrice: json['servicePrice'] ?? 0,
      serviceLocation: json['serviceLocation'] ?? '',
      serviceImage: json['serviceImage'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  ServiceDetailEntity toEntity() => ServiceDetailEntity(
      serviceId: serviceId,
      serviceTitle: serviceTitle,
      serviceDescription: serviceDescription,
      serviceCategory: serviceCategory,
      servicePrice: servicePrice,
      serviceLocation: serviceLocation,
      serviceImage: serviceImage,
      createdAt: createdAt);

  ServiceDetailModel.empty()
      : serviceId = '',
        serviceTitle = '',
        serviceDescription = '',
        serviceCategory = '',
        servicePrice = 0,
        serviceLocation = '',
        serviceImage = '',
        createdAt = '';
}
