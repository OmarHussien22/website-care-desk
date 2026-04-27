import 'package:coursaty/src/core/styles/colors/app_colors.dart';
import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';

class RowShowAll extends StatelessWidget {
  final String title;
  final String? counter;
  final VoidCallback? onTap;
  final bool hasSpacing;

  const RowShowAll({
    Key? key,
    required this.title,
    this.onTap,
    this.counter,
    this.hasSpacing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: hasSpacing
          ? EdgeInsets.symmetric(vertical: 20.toH())
          : EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: CustomText(title, fontSize: 16, fontWeight: FW.semiBold),
          ),
          if (counter != null) ...[
            CustomText('($counter)', fontSize: 16, fontWeight: FW.semiBold),
          ],
          if (onTap != null) ...[
            const Spacer(),
            GestureDetector(
              onTap: onTap,
              child: CustomText(
                "show_all",
                fontSize: 12,
                fontWeight: FW.light,
                color: AppColors.get.cardSubTitle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
