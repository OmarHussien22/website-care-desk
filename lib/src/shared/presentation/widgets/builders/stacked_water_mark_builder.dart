import 'dart:math' as math;

import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';

class StackedWaterMarkBuilder extends StatelessWidget {
  final Widget child;
  const StackedWaterMarkBuilder({Key? key, required this.child})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        child,
        AbsorbPointer(
          child: Transform.rotate(
            angle: (math.pi) / 3.8,
            child: const CustomText(
              "",
              // (UserCache.instance.getUser().phone ?? "").toString(),
              color: Colors.black12,
              fontSize: 110,
              letterSpacing: 4,
            ),
          ),
        ),
      ],
    );
  }
}
