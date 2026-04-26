import 'interface_flavor.dart';
import 'qudorat/qudorat_flavor.dart';


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
