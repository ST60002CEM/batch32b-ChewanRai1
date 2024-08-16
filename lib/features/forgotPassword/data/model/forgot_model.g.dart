// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPassword _$ForgotPasswordFromJson(Map<String, dynamic> json) =>
    ForgotPassword(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ForgotPasswordToJson(ForgotPassword instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
