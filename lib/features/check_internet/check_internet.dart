// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class Internet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Internet Connectivity',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Internet Connectivity Checker'),
//         ),
//         body: ConnectivityStatus(),
//       ),
//     );
//   }
// }

// class ConnectivityStatus extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ConnectivityProvider>(
//       builder: (context, connectivityProvider, child) {
//         String status = connectivityProvider.isOnline ? "Online" : "Offline";
//         return Center(
//           child: Text(
//             'Internet Status: $status',
//             style: TextStyle(fontSize: 24),
//           ),
//         );
//       },
//     );
//   }
// }

// class ConnectivityProvider extends ChangeNotifier {
//   bool _isOnline = false;
//   bool get isOnline => _isOnline;

//   ConnectivityProvider() {
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//           _isOnline = result != ConnectivityResult.none;
//           notifyListeners();
//         } as void Function(List<ConnectivityResult> event)?);
//   }
// }

import 'package:finalproject/core/common/provider/internet_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckInternet extends ConsumerWidget {
  const CheckInternet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Internet Checker'),
        ),
        body: Center(
          child: Consumer(
            builder: (context, ref, child) {
              final connectivityStatus = ref.watch(connectivityStatusProvider);
              if (connectivityStatus == ConnectivityStatus.isConnected) {
                return const Text(
                  'Connected',
                  style: TextStyle(fontSize: 24),
                );
              } else {
                return const Text(
                  'Disconnected',
                  style: TextStyle(fontSize: 24),
                );
              }
            },
          ),
        ));
  }
}
