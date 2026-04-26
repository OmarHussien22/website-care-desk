import 'package:wakelock_plus/wakelock_plus.dart';

import '../utils/general_utils.dart';

class WakelockService {
  WakelockService._();

  static final WakelockService instance = WakelockService._();

  Future<void> enable() async {
    printDM('WakelockService: Enabling wakelock');
    await WakelockPlus.enable();
    printDM('WakelockService: Wakelock enabled: ${await WakelockPlus.enabled}');
  }

  Future<void> disable() async {
    printDM('WakelockService: Disabling wakelock');
    await WakelockPlus.disable();
    printDM('WakelockService: Wakelock enabled: ${await WakelockPlus.enabled}');
  }

  Future<bool> isEnabled() async {
    return WakelockPlus.enabled;
  }
}
