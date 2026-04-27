import 'package:flutter/cupertino.dart';

import '../../../../../core/constants/decorations/app_insets.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../image/generic_image/src/generic_image_lib.dart';
import '../image/generic_image/src/options/image_options.dart';
import '../spaces_dividers/custom_divider.dart';
import '../text/custom_text_lib.dart';
import 'sheet_indicator.dart';

class CustomSheet extends StatelessWidget {
  final Widget body;
  final double? height;
  final String title;
  final String icon;
  final String subtitle;
  final Widget? footer;
  final Widget? stackWidget;

  const CustomSheet({
    super.key,
    required this.body,
    required this.title,
    required this.subtitle,
    this.height,
    this.footer, required this.icon, this.stackWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: (height ?? 700).toH(),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: AppInsets.defaultScreenALL,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SheetIndicator(
                        verticalSpacing: 7,
                      ),

                      if (title.isNotEmpty) ...[
                        Row(
                          children: [

                            if(icon.isNotEmpty) ...[ Container(
                              height: 28.toW(),
                              width: 28.toW(),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(6.toW()),
                              decoration: BoxDecoration(
                                color: AppColors.get.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: FittedBox(
                                child: ImageGeneric.svg(
                                    url: icon ?? '',
                                    options: ImageOptions(
                                      width: 16.toW(),
                                      height: 16.toH(),
                                      color: AppColors.get.primary,
                                    )

                                ),
                              ),
                            ),
                              12.ESW(),
                            ],
                            CustomText(
                              title,
                              fontSize: 14,
                              fontWeight: FW.medium,
                            ),
                          ],
                        ),
                      ],
                      if (subtitle.isNotEmpty) ...[
                        5.ESH(),
                        CustomText.subtitle(
                          subtitle,
                          fontSize: 12,
                          fontWeight: FW.medium,
                        ),
                      ],
                      if (title.isNotEmpty || subtitle.isNotEmpty) ...[
                        const AppDivider(),
                      ],
                      Expanded(child: body),
                    ],
                  ),
                ),
              ),
              if (footer != null) ...[
                footer!,
              ],
            ]
            ,
          )
          ,
        ),
        stackWidget??0.ESH()
      ],
    );
  }
}
