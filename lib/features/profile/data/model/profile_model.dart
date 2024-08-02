import 'package:json_annotation/json_annotation.dart';
import 'package:finalproject/features/profile/domain/entity/profile_entity.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  @JsonKey(name: "_id") // Mapping "_id" from the JSON response
  final String userId;
  final String? fname;
  final String? lname;
  final String? phone;
  final String? email;
  final String? username;

  ProfileModel({
    required this.userId,
    this.fname,
    this.lname,
    this.phone,
    this.email,
    this.username,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  ProfileEntity toEntity() => ProfileEntity(
        fname: fname ?? "",
        lname: lname ?? "",
        phone: phone ?? "",
        email: email ?? "",
        username: username ?? "",
        userId: userId,
      );
}
