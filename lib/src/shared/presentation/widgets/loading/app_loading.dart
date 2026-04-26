import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:flutter/material.dart';

import 'loading.dart';
import 'loading_box.dart';

//TODO 7.a : change to loading widget
class AppLoader extends StatelessWidget {
  final double? heightRatio;
  final bool? isFullScreen;
  const AppLoader({super.key, this.heightRatio, this.isFullScreen});

  @override 
  Widget build(BuildContext context) {
    return LoadingBox(
      loading: Loading.discreteCircle(
        size: 45.toH(),
      ),
      heightRatio: heightRatio ?? 1,
      isFullScreen: isFullScreen ?? false,
    );
  }
}
  