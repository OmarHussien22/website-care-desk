import 'package:coursaty/src/flavors/interface_flavor.dart';
import 'package:coursaty/src/flavors/qudorat/qudorat_flavor.dart';


class FlavorHolder {
  FlavorHolder._();

  static FlavorHolder? _instance;

  static FlavorHolder get instance => _instance ??= FlavorHolder._();

  InterfaceFlavor? _flavor;

  set flavor(InterfaceFlavor flavor) {
    _flavor = flavor;
  }

  InterfaceFlavor get flavor => _flavor ??QudoratFlavor();
}
