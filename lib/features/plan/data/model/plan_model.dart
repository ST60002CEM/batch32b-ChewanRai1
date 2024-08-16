import 'package:finalproject/features/plan/domain/entity/plan_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plan_model.g.dart';

@JsonSerializable()
class FavoriteModel {
  @JsonKey(name: '_id')
  final String serviceId;
  final String serviceTitle;
  final int servicePrice;
  final String serviceDescription;
  final String serviceCategory;
  final String serviceLocation;
  final String serviceImage;

  FavoriteModel({
    required this.serviceId,
    required this.serviceTitle,
    required this.servicePrice,
    required this.serviceDescription,
    required this.serviceCategory,
    required this.serviceLocation,
    required this.serviceImage,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteModelToJson(this);

  FavoriteEntity toEntity() {
    return FavoriteEntity(
      serviceId: serviceId,
      serviceTitle: serviceTitle,
      servicePrice: servicePrice,
      serviceDescription: serviceDescription,
      serviceCategory: serviceCategory,
      serviceLocation: serviceLocation,
      serviceImage: serviceImage,
    );
  }
}
