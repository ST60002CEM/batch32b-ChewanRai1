// // data/repositories/auth_repository_impl.dart
// import 'package:finalproject/core/shared_prefs/user_shared_prefs.dart';
// import 'package:finalproject/features/auth/data/data_source/local/auth_local_data_source.dart';
// import 'package:finalproject/features/auth/data/data_source/remote/auth_remote_data_source.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final AuthLocalDataSource authLocalDataSource;
//   final AuthRemoteDataSource authRemoteDataSource;
//   final UserSharedPrefs userSharedPrefs;

//   AuthRepositoryImpl({
//     required this.authLocalDataSource,
//     required this.authRemoteDataSource,
//     required this.userSharedPrefs,
//   });

//   @override
//   Future<void> logout() async {
//     await authLocalDataSource.clearSession();
//     await userSharedPrefs.deleteUserToken();
//   }
// }