import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  @JsonKey(name: '_id')
  final String id;
  final String
      fname; // Make this nullable to handle cases where it's not present

  UserDTO({
    required this.id,
    required this.fname, // Nullable
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['_id'] as String,
      fname: json['fname'] as String, // Nullable
    );
  }

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
