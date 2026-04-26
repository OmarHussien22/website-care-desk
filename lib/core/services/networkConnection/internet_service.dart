import 'dart:async';

import '../../utils/general_utils.dart';
import 'internet_connection_package/internet_connection_checker.dart';

class InternetService {
  late StreamSubscription subscriptionNetWork;
  bool hasConnection = true;

  Function? _onlineFunction;
  Function? _offlineFunction;

   setFunctions({Function? onlineFunction, Function? offlineFunction}) {
    _onlineFunction = onlineFunction;
    _offlineFunction = offlineFunction;

  }

  startListenCheckNetwork() {
    printDM("startListenCheckNetwork   started");
    subscriptionNetWork =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final connected = status == InternetConnectionStatus.connected;

      if (connected != hasConnection) {
        hasConnection = connected;
        printDM("startListenCheckNetwork   hasConnection $hasConnection");
        if (hasConnection) {
          if (_onlineFunction != null) {
            _onlineFunction!();
          }
        } else {
          if (_offlineFunction != null) {
            _offlineFunction!();
          }
        }
      }
    });
  }

  disposeListenCheckNetwork() {
    subscriptionNetWork.cancel();
  }
}
