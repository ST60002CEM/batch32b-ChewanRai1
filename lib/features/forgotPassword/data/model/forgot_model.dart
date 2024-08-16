import 'package:finalproject/features/forgotPassword/domain/entity/forgot_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_model.g.dart';

final forgotPasswordModelProvider = Provider((ref) {
  return ForgotPassword.empty();
});

@JsonSerializable()
class ForgotPassword {
  final bool success;
  final String message;

  const ForgotPassword({
    required this.success,
    required this.message,
  });

  factory ForgotPassword.fromJson(Map<String, dynamic> json) {
    return ForgotPassword(
      success: json['success'],
      message: json['message'],
    );
  }

  ForgotPasswordEntity toEntity() => ForgotPasswordEntity(
        success: success,
        message: message,
      );

  ForgotPassword.empty()
      : success = false,
        message = '';
}
