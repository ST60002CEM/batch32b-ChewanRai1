
import 'package:finalproject/features/post/domain/entity/post_service_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_service_model.g.dart';

@JsonSerializable()
class PostServiceModel {
  @JsonKey(name: '_id')
  final String serviceId;
  final String serviceTitle;
  final String serviceDescription;
  final String serviceCategory;
  final double servicePrice;
  final String serviceLocation;
  final String contact;
  final String serviceImage;
  final String createdBy;

  const PostServiceModel({
    required this.serviceId,
    required this.serviceTitle,
    required this.serviceDescription,
    required this.serviceCategory,
    required this.servicePrice,
    required this.serviceLocation,
    required this.contact,
    required this.serviceImage,
    required this.createdBy,
  });

  factory PostServiceModel.fromJson(Map<String, dynamic> json) => _$PostServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostServiceModelToJson(this);

  PostServiceEntity toEntity() {
    return PostServiceEntity(
      serviceId: serviceId,
      serviceTitle: serviceTitle,
      serviceDescription: serviceDescription,
      serviceCategory: serviceCategory,
      servicePrice: servicePrice,
      serviceLocation: serviceLocation,
      contact: contact,
      serviceImage: serviceImage,
      createdBy: createdBy,
    );
  }
}
