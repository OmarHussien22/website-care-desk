import 'dart:developer';

import '../../../packages_index.dart';

class MyRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log("PUSHED ROUTE: ${route.settings.name}");
  }
}
