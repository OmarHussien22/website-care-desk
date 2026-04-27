import 'package:coursaty/src/core/network_structure/resources/errors/error_model.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SimpleErrorHandlerBuilder extends StatelessWidget {
  final ErrorModel? error;

  const SimpleErrorHandlerBuilder({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 50,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            if (kDebugMode) ...[
              CustomText(
                error?.type.toString() ?? "",
                fontSize: 20,
                isBold: true,
              ),
              const SizedBox(height: 20),
            ],
            CustomText.subtitle("illustration_something_went_wrong_details"),
          ],
        ),
      ),
    );
  }
}
