// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    FavoriteModel(
      serviceId: json['_id'] as String,
      serviceTitle: json['serviceTitle'] as String,
      servicePrice: (json['servicePrice'] as num).toInt(),
      serviceDescription: json['serviceDescription'] as String,
      serviceCategory: json['serviceCategory'] as String,
      serviceLocation: json['serviceLocation'] as String,
      serviceImage: json['serviceImage'] as String,
    );

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      '_id': instance.serviceId,
      'serviceTitle': instance.serviceTitle,
      'servicePrice': instance.servicePrice,
      'serviceDescription': instance.serviceDescription,
      'serviceCategory': instance.serviceCategory,
      'serviceLocation': instance.serviceLocation,
      'serviceImage': instance.serviceImage,
    };
