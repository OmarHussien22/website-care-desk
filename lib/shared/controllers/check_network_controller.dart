import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../core/services/helper.dart';
import '../../../core/services/utils/general_utils.dart';
import '../../../core/services/utils/snack_utils/src/app_snacks.dart';
import '../../../core/services/utils/snack_utils/src/constants/snack_constants.dart';
import '../../super/controllers/resources/get/get_controller_interface.dart';

class CheckNetworkController extends GetControllerInterface {
  final  _networkConnectivity = Helper.connectivity;
  String _connectionString = '';

  // Enhancement: State tracking and debounce
  bool? _isOnline;
  Timer? _debounceTimer;
  final Duration _onlineDebounce = const Duration(seconds: 1);
  final Duration _offlineDebounce = const Duration(seconds: 5);

  @override
  void onInit() {
    super.onInit();
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _handleConnectionChange(source);
    });
  }

  void _handleConnectionChange(Map source) {
    final ConnectivityResult connectivity = source.keys.toList()[0];
    final bool isOnlineStatus = source.values.toList()[0];

    // Determine the target online state
    final bool targetIsOnline = (connectivity != ConnectivityResult.none) && isOnlineStatus;

    // 1. Initial state: Apply immediately
    if (_isOnline == null) {
      _applyStateChange( connectivity, isOnlineStatus, targetIsOnline);
      return;
    }

    // 2. No change: Cancel any pending debounce timer
    if (_isOnline == targetIsOnline) {
      _debounceTimer?.cancel();
      _debounceTimer = null;
      return;
    }

    // 3. State change detected: Start debounce timer
    _debounceTimer?.cancel();
    final delay = targetIsOnline ? _onlineDebounce : _offlineDebounce;

    _debounceTimer = Timer(delay, () {
      _applyStateChange(connectivity, isOnlineStatus, targetIsOnline);
    });
  }

  void _applyStateChange(ConnectivityResult connectivity, bool isOnlineStatus, bool targetIsOnline) {
    _isOnline = targetIsOnline;

    printDM('Connection state applied: $_isOnline (Source: $connectivity)');

    switch (connectivity) {
      case ConnectivityResult.mobile:
        _connectionString = isOnlineStatus ? 'Mobile: Online' : 'Mobile: Offline';
        break;
      case ConnectivityResult.wifi:
        _connectionString = isOnlineStatus ? 'WiFi: Online' : 'WiFi: Offline';
        break;
      case ConnectivityResult.none:
      default:
        _connectionString = 'Offline';
    }

    update();
    AppSnacks().showSnack(
      title: _connectionString,
      state: _isOnline! ? UtilState.success : UtilState.error,
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _networkConnectivity.disposeStream();
    super.dispose();
  }
}
