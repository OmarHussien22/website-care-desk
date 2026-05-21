import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../core/services/network_connection/network_service.dart';
import '../../../core/services/helper.dart';
import '../../../core/utils/snack_utils/src/constants/snack_constants.dart';
import '../../../core/utils/snack_utils/src/app_snacks.dart';
import '../../../core/utils/general_utils.dart';
import '../../../super/controllers/resources/get/get_controller_interface.dart';

class CheckNetworkController extends GetControllerInterface {
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectionService _networkConnectivity = Helper.connectivity;
  String _connectionString = '';
  @override
  void onInit() {
    super.onInit();
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      printDM('source $_source');
      // 1.
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          _connectionString =
              _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
          break;
        case ConnectivityResult.wifi:
          _connectionString =
              _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
          break;
        case ConnectivityResult.none:
        default:
          _connectionString = 'Offline';
      }
      // 2.
      update();
      // 3.
      AppSnacks().showSnack(title: _connectionString, state: UtilState.none);
    });
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    // TODO: implement dispose
    super.dispose();
  }
}
