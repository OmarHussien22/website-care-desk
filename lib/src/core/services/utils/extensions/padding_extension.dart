import '../../../../../packages_index.dart';
import '../../../constants/decorations/app_Insets.dart';

extension PaddingExtension on Widget {
  Widget withPaddingOnly({
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left ?? 0,
        right: right ?? 0,
        top: top ?? 0,
        bottom: bottom ?? 0,
      ),
      child: this,
    );
  }

  Widget withPaddingSymmetric({
    double? horizontal,
    double? vertical,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ?? 0,
        vertical: vertical ?? 0,
      ),
      child: this,
    );
  }

  Widget withPaddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget paddingDirectionalOnly(
      {double? start, double? top, double? end, double? bottom}) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: start ?? 0,
        top: top ?? 0,
        end: end ?? 0,
        bottom: bottom ?? 0,
      ),
      child: this,
    );
  }

  /// Defaults

  Widget withPaddingAllDefault() {
    return Padding(
      padding: AppInsets.defaultScreenALL,
      child: this,
    );
  }

  Widget withPaddingHorizontalDefault() {
    return Padding(
      padding: AppInsets.defaultScreenHorizontal,
      child: this,
    );
  }

  Widget withPaddingVerticalDefault() {
    return Padding(
      padding: AppInsets.defaultScreenVertical,
      child: this,
    );
  }
}
