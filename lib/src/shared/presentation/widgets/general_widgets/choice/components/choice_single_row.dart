import 'package:flutter/material.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../../../../domain/entities/title_interface.dart';
import '../../image/generic_image/src/parts/imports_parts.dart';
import '../../image/generic_image/src/options/image_options.dart';
import '../../text/custom_text_lib.dart';
import 'choice_single_circle.dart';

class ChoiceSingleRow<T extends TitleInterface> extends StatelessWidget {
  final T item;
  final bool active;
  final double? titleTextSize;
  final double choiceWidth;
  final double choiceHeight;
  final VoidCallback onTap;
  final Widget? builder;
  const ChoiceSingleRow({
    super.key,
    required this.item,
    this.active = false,
    required this.onTap,
    this.titleTextSize = 16,
    this.choiceWidth = 20,
    this.choiceHeight = 20,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        // height: 36.toH(),
        child: Row(
          children: [
            if (item.image != null && (item.image ?? '').isNotEmpty) ...[
              ImageNetwork(
                url: item.image ?? '',
                options: const ImageOptions(
                  radius: 30,
                  fit: BoxFit.cover,
                ),
              ),
              8.ESH(),
            ],
            Expanded(
              child: builder ??
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              item.title,
                              color: AppColors.get.black,
                              fontSize: 16,
                              fontWeight: FW.medium,
                            ),
                          ),
                        ],
                      ),
                      if (item.subTitle != null) ...[
                        8.ESH(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                item.subTitle ?? '',
                                color: AppColors.get.grey,
                                fontSize: 13,
                                fontWeight: FW.regular,
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
            ),
            ChoiceSingleCircle(
              isActive: active,
              height: choiceHeight,
              width: choiceWidth,
            ),
          ],
        ),
      ),
    );
  }
}
