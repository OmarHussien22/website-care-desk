import 'package:coursaty/src/core/utils/general_utils.dart';
import 'package:coursaty/src/flavors/flavor_holder.dart';
import 'package:coursaty/src/flavors/qudorat/qudorat_flavor.dart';

class FlavorInject {
  static void injectFlavor() {
    const flavor = String.fromEnvironment('FLAVOR');
    printDM("flavor is $flavor");
    switch (flavor) {
      case 'qudorat':
        FlavorHolder.instance.flavor = QudoratFlavor();
        printDM('qudorat flavor injected');
        break;
    }
  }
}
