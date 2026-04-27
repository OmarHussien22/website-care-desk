import 'package:coursaty/src/shared/presentation/widgets/loading/loading_box.dart';
import 'package:flutter/material.dart';

import 'loading.dart';

//TODO 7.a : change to loading widget
class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingBox(loading: Loading.stretchedDots());
  }
}
