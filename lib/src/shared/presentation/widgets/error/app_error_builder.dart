import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:coursaty/src/shared/presentation/widgets/builders/conditional_builder.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:coursaty/src/shared/presentation/widgets/illustrations/imports_illustrations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppErrorBuilder extends StatelessWidget {
  final FlutterErrorDetails details;

  const AppErrorBuilder(this.details, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: kReleaseMode,
      onBuild: const IllustrationSomethingWrongScreen(),
      onFeedBack: SingleChildScrollView(
        child: Column(
          children: [
            CustomText(
              details.exception.toString(),
              fontWeight: FW.semiBold,
              fontSize: 16,
            ),
            16.0.ESH(),
            CustomText.subtitle(
              details.exceptionAsString(),
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              fontSize: 13,
              fontWeight: FW.light,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
