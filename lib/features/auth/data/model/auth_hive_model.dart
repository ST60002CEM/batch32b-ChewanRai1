import 'package:finalproject/app/constants/hive_table_constant.dart';
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String? userId;

  @HiveField(1)
  final String fname;

  @HiveField(2)
  final String lname;

  @HiveField(3)
  final String phone;

  // @HiveField(4)
  // final BatchHiveModel batch;

  // @HiveField(5)
  // final List<CourseHiveModel> courses;
  @HiveField(4)
  final String email;

  @HiveField(5)
  final String username;

  @HiveField(6)
  final String password;

  // Constructor
  AuthHiveModel({
    String? userId,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.email,
    // required this.batch,
    // required this.courses,
    required this.username,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          fname: '',
          lname: '',
          phone: '',
          email: '',
          // batch: BatchHiveModel.empty(),
          // courses: [],
          username: '',
          password: '',
        );

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        id: userId,
        fname: fname,
        lname: lname,
        phone: phone,
        email: email,
        // batch: batch.toEntity(),
        // courses: CourseHiveModel.empty().toEntityList(courses),
        username: username,
        password: password,
      );

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        userId: const Uuid().v4(),
        fname: entity.fname,
        lname: entity.lname,
        phone: entity.phone,
        email: entity.email,
        // batch: BatchHiveModel.empty().fromEntity(entity.batch),
        // courses: CourseHiveModel.empty().fromEntityList(entity.courses),
        username: entity.username,
        password: entity.password,
      );

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId, fname: $fname, lname: $lname, phone: $phone, email: $email, username: $username, password: $password';
  }
}
