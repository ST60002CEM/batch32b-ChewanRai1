// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_service_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostServiceDTO _$PostServiceDTOFromJson(Map<String, dynamic> json) =>
    PostServiceDTO(
      service:
          PostServiceModel.fromJson(json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostServiceDTOToJson(PostServiceDTO instance) =>
    <String, dynamic>{
      'service': instance.service,
    };
