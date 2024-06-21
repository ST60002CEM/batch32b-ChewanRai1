import 'package:finalproject/app/app.dart';
// import 'package:flutter_application_1/app/app..dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await HiveService().init();
  // await MongoDatabase.connect();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
