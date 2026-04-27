import 'package:flutter/material.dart';

import '../../../../../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../../../../buttons/basic/button_default.dart';
import '../../../../../buttons/basic/custom_rounded_button.dart';

class SheetFooterBasic extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const SheetFooterBasic({
    Key? key,
    this.title = 'save',
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 16.0.toW(), vertical: 16.0.toH()),
      child: ButtonDefault(
        title: title,
        onPressed: onPressed,
      ),
    );
  }
}
