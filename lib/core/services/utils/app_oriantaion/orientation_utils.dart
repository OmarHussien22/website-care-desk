import 'dart:ui';

class OrientationUtils {
  OrientationUtils._();

  static OrientationUtils instance = OrientationUtils._();

  final double _fSPercentage = 1.8;
  final double _hPercentage = 1.8;
  // final double _wPercentage = 1;

  bool isLandscape() {
    Size size = PlatformDispatcher.instance.views.first.physicalSize;
    double pixelRatio =
        PlatformDispatcher.instance.views.first.devicePixelRatio;
    Size logicalSize = size / pixelRatio;

    return logicalSize.width > logicalSize.height;
  }

  double fontSize(double fontSize) {
    return isLandscape() ? fontSize / _fSPercentage : fontSize;
  }

  double height(double height) {
    return isLandscape() ? height * _hPercentage : height;
  }

  double width(double height) {
    return height;
    // return isLandscape() ? height * 1 : height;
  }
}
