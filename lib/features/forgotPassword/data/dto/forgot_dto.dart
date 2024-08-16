import 'package:json_annotation/json_annotation.dart';

part 'forgot_dto.g.dart';

@JsonSerializable()
class ForgotPasswordDto {
  final bool success;
  final String message;

  ForgotPasswordDto({
    required this.success,
    required this.message,
  });

  factory ForgotPasswordDto.fromJson(Map<String, dynamic> json) => _$ForgotPasswordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordDtoToJson(this);
}
