// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceDetailDto _$ServiceDetailDtoFromJson(Map<String, dynamic> json) =>
    ServiceDetailDto(
      success: json['success'] as bool,
      data:
          ServiceDetailModel.fromJson(json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceDetailDtoToJson(ServiceDetailDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'service': instance.data,
    };
