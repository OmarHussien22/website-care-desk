import 'package:flutter/cupertino.dart';

import '../../../../../core/constants/decorations/app_insets.dart';
import '../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../spaces_dividers/custom_divider.dart';
import 'sheet_indicator.dart';

class SheetWidgetTitle extends StatelessWidget {
  final Widget body;
  final Widget title;
  final double? height;

  const SheetWidgetTitle({
    super.key,
    required this.body,
    required this.title,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (height ?? 700).toH(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppInsets.defaultScreenALL,
            child: const SheetIndicator(
              verticalSpacing: 7,
            ),
          ),
          title,
          const AppDivider(),
          Expanded(child: body),
        ],
      ),
    );
  }
}
