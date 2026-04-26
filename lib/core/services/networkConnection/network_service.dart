import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../utils/general_utils.dart';
import 'internet_connection_package/internet_connection_checker.dart';

class NetworkConnectionService {
  NetworkConnectionService._();

  static final NetworkConnectionService instance = NetworkConnectionService._();

  /// create an instance to access other attributes
  static final Connectivity _connectivity = Connectivity();
  static final InternetConnectionChecker _internetConnectionChecker =
      InternetConnectionChecker();

  /// package starts here !
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  // 1.This calls for both methods to manually check the internet connection and listen for the connectivity stream.
  void initialise() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      printDM("$result");
      _checkStatus(result);
    });
  }

// 2.This calls for both methods to manually check the internet connection and listen for the connectivity stream.
  void _checkStatus( List<ConnectivityResult> connectivityResults) async {
    bool isOnline = false;
    for (var connectivityResult in connectivityResults) {
      try {
        {
          if (connectivityResult != ConnectivityResult.none) {
            isOnline = await _internetConnectionChecker.hasConnection;
          }
        }
        // final connectivityResult = await InternetAddress.lookup('example.com');
        //  isOnline = connectivityResult.isNotEmpty && connectivityResult[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        isOnline = false;
      }
      _controller.sink.add({connectivityResult: isOnline});
    }
  }

  void disposeStream() => _controller.close();

  /// FOR USAGE : see [AppController]
}

/// OLD VERSION depends on [Connectivity] package only
// class NetworkConnectionService {
//   NetworkConnectionService._();
//   static final NetworkConnectionService instance = NetworkConnectionService._();
//   /// create an instance to access other attributes
//   static final Connectivity _connection = Connectivity();
//
//
//
//
//   Future<bool> get isConnected async => (await _connection.checkConnectivity() == ConnectivityResult.none);
//
//   void checkConnection({
//     VoidCallback? onConnection,
//     VoidCallback? onDisconnection,
//   }) async {
//     var connectivityResult = await (_connection.checkConnectivity());
//
//     if (connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.wifi) {
//       if (kDebugMode) {
//         print("I am connected to a ${connectivityResult.name}");
//       }
//       onConnection!();
//     } else {
//       if (kDebugMode) {
//         print("I am disConnected from the internet");
//       }
//       onDisconnection!();
//     }
//   }
//
//   /// Listens to the changes in network connections
//   /// Warning : as any Stream you should init when you listen and dispose after using .
//   Stream<ConnectivityResult> onConnectionChange() {
//     return _connection.onConnectivityChanged;
//   }
//
// }
