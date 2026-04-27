import 'package:flutter/material.dart';

import 'src/core/app/app_initializer.dart';
import 'src/my_app.dart';

// end background
void main() async {
  await AppInitializer.initializeApp();

  // * dont't use sentry when add dsn for another email
  // if (kReleaseMode) {
  //   await SentryFlutter.init(
  //     (options) {
  //       options.dsn =
  //           'https://8aada572d26425b37fb8c7ff707e2f07@o4509802530668544.ingest.de.sentry.io/4509802532241488';
  //       // Adds request headers and IP for users,
  //       // visit: https://docs.sentry.io/platforms/dart/data-management/data-collected/ for more info
  //       options.sendDefaultPii = true;
  //     },
  //     appRunner: () => runApp(
  //       SentryWidget(
  //         child: const MyApp(),
  //       ),
  //     ),
  //   );
  // } else {
  runApp(const MyApp());
  // }
}
