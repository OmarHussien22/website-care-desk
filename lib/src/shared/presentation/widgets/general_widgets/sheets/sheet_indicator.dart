import 'package:flutter/material.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../spaces_dividers/custom_divider.dart';

class SheetIndicator extends StatelessWidget {
  final double verticalSpacing;
  const SheetIndicator({Key? key, this.verticalSpacing = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        XDivider.normal(
          color: AppColors.get.opposite,
          verticalPadding: verticalSpacing.toH(),
          horizontalPadding: 145.toW(),
          height: 3,
        ),
        SizedBox(
          height: 5.toH(),
        ),
      ],
    );
  }
}
