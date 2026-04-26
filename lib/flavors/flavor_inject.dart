import '../core/services/utils/general_utils.dart';
import 'flavor_holder.dart';
import 'qudorat/qudorat_flavor.dart';

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
