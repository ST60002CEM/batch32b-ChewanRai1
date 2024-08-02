class ProfileEntity {
  final String fname;
  final String lname;
  final String phone;
  final String email;
  final String username;
  final String userId;

  ProfileEntity({
    required this.fname,
    required this.lname,
    required this.phone,
    required this.email,
    required this.username,
    required this.userId,
  });

  ProfileEntity copyWith({
    String? fname,
    String? lname,
    String? phone,
    String? email,
    String? username,
    String? userId,
  }) {
    return ProfileEntity(
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      username: username ?? this.username,
      userId: userId ?? this.userId,
    );
  }
}
