import 'package:coursaty/src/core/utils/extensions/basic_op_extensions.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/choice/components/choice_multi_circle.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../../../../domain/entities/title_interface.dart';
import '../../../builders/conditional_builder.dart';
import '../../image/generic_image/src/generic_image_lib.dart';
import '../../image/generic_image/src/options/image_options.dart';
import '../../text/custom_text_lib.dart';

class ChoiceMultiRow<T extends TitleInterface> extends StatelessWidget {
  final T item;
  final bool active;
  final VoidCallback onTap;
  final Widget? builder;

  const ChoiceMultiRow({
    super.key,
    required this.item,
    this.active = false,
    required this.onTap,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.toH()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (item.image != null && (item.image ?? '').isNotEmpty) ...[
                ConditionalBuilder(
                  condition: !item.image.noneNull.contains('http'),
                  onBuild: ImageGeneric.asset(
                    url: item.image ?? '',
                    options: ImageOptions(radius: 30.toW()),
                  ),
                  onFeedBack: ImageGeneric.network(
                    url: item.image ?? '',
                    options: ImageOptions(radius: 30.toW()),
                  ),
                ),
                8.ESW(),
              ],
              Expanded(
                child:
                    builder ??
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        ],
                      ],
                    ),
              ),
              ChoiceMultiCircle(isActive: active),
            ],
          ),
        ),
      ),
    );
  }
}
