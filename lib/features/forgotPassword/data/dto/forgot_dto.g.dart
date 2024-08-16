// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordDto _$ForgotPasswordDtoFromJson(Map<String, dynamic> json) =>
    ForgotPasswordDto(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ForgotPasswordDtoToJson(ForgotPasswordDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
