// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostServiceModel _$PostServiceModelFromJson(Map<String, dynamic> json) =>
    PostServiceModel(
      serviceId: json['_id'] as String,
      serviceTitle: json['serviceTitle'] as String,
      serviceDescription: json['serviceDescription'] as String,
      serviceCategory: json['serviceCategory'] as String,
      servicePrice: (json['servicePrice'] as num).toDouble(),
      serviceLocation: json['serviceLocation'] as String,
      contact: json['contact'] as String,
      serviceImage: json['serviceImage'] as String,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$PostServiceModelToJson(PostServiceModel instance) =>
    <String, dynamic>{
      '_id': instance.serviceId,
      'serviceTitle': instance.serviceTitle,
      'serviceDescription': instance.serviceDescription,
      'serviceCategory': instance.serviceCategory,
      'servicePrice': instance.servicePrice,
      'serviceLocation': instance.serviceLocation,
      'contact': instance.contact,
      'serviceImage': instance.serviceImage,
      'createdBy': instance.createdBy,
    };
