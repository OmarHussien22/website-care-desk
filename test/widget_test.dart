import 'package:coursaty/src/landing/presentation/pages/landing_page.dart';
import 'package:coursaty/src/my_app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final size in const [
    Size(375, 900),
    Size(768, 1024),
    Size(1440, 1000),
  ]) {
    testWidgets('MedDesk landing renders at ${size.width}px', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MyApp());
      await tester.pump(const Duration(milliseconds: 800));

      expect(find.byType(LandingPage), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 1));
    });
  }
}
