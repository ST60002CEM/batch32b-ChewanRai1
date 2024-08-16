import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetCurrentUserDto {
  @JsonKey(name: "_id")
  final String id;
  final String fname;
  final String lname;
  final String phone;
  // final String? image; // Optional field
  final String username;
  final String email;
  // final String? batch; // Optional field
  // final List<String>? course; // Optional field

  GetCurrentUserDto({
    required this.id,
    required this.fname,
    required this.lname,
    required this.phone,
    // this.image, // Optional field
    required this.username,
    required this.email,
    // this.batch, // Optional field
    // this.course, // Optional field
  });

  AuthEntity toEntity() {
    return AuthEntity(
        id: id,
        fname: fname,
        lname: lname,
        // image: image ?? '', // Default value if null
        phone: phone,
        email: email,
        username: username,
        password: ''
        // batch: batch ?? '', // Default value if null
        // courses: course?.map((course) {
        //       return CourseEntity(courseId: course, courseName: '');
        //     }).toList() ??
        //     [], // Default empty list if null
        );
  }

  factory GetCurrentUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrentUserDtoToJson(this);
}
