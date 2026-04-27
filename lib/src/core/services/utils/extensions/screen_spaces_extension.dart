import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_oriantaion/orientation_utils.dart';

extension ScreenSpaces on num {
  // ignore: non_constant_identifier_names
  /// Sized Box with Width
  SizedBox ESW() => SizedBox(
        width: toW(),
      );

  /// Sized Box with height
  // ignore: non_constant_identifier_names
  SizedBox ESH() => SizedBox(
        height: toH(),
      );

  SliverToBoxAdapter sESH() => SliverToBoxAdapter(
        child: SizedBox(
          height: toH(),
        ),
      );

  SliverToBoxAdapter sESW() => SliverToBoxAdapter(
        child: SizedBox(
          width: toW(),
        ),
      );

  /// radius
  // ignore: non_constant_identifier_names
  double toRad() => (OrientationUtils.instance.height(r));
 
  /// font size
  // ignore: non_constant_identifier_names
  double toFS() => (OrientationUtils.instance.fontSize(sp));

// double toFS() => (toDouble());

  /// height
  double toH() => (OrientationUtils.instance.height(h));

  /// width
  double toW() => (OrientationUtils.instance.width(w));
}
