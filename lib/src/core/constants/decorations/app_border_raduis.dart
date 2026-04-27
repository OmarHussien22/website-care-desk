
import '../../../../packages_index.dart';

class AppBorderRaduis {
  AppBorderRaduis._();

  static final defaultOuterRaduis = 16.r;
  static final defaultInnerRaduis = 12.r;

  static BorderRadius get defaultOuter => wholeOuter;
  static BorderRadius get defaultInner => wholteInner;

  /// Whole
  /// - Inner
  static BorderRadius get wholeOuter =>
      BorderRadius.circular(defaultOuterRaduis);

  /// - Outer
  static BorderRadius get wholteInner =>
      BorderRadius.circular(defaultInnerRaduis);

  /// Vertical
  /// - Outer
  static BorderRadius get topOuter => BorderRadius.vertical(
        top: Radius.circular(defaultOuterRaduis),
      );

  static BorderRadius get bottomOutter => BorderRadius.vertical(
        bottom: Radius.circular(defaultOuterRaduis),
      );

  /// - Inner
  static BorderRadius get topInner => BorderRadius.vertical(
        top: Radius.circular(defaultInnerRaduis),
      );

  static BorderRadius get bottomInner => BorderRadius.vertical(
        bottom: Radius.circular(defaultInnerRaduis),
      );

  /// Horizontal
  /// - Outer
  static BorderRadius get leftOuter => BorderRadius.horizontal(
        left: Radius.circular(defaultOuterRaduis),
      );

  static BorderRadius get rightOuter => BorderRadius.horizontal(
        right: Radius.circular(defaultOuterRaduis),
      );

  /// - Inner
  static BorderRadius get leftInner => BorderRadius.horizontal(
        left: Radius.circular(defaultInnerRaduis),
      );

  static BorderRadius get rightInner => BorderRadius.horizontal(
        right: Radius.circular(defaultInnerRaduis),
      );

  /// Corners
  /// - Outer
  static BorderRadius get topLeftOuter => BorderRadius.only(
        topLeft: Radius.circular(defaultOuterRaduis),
      );

  static BorderRadius get topRightOuter => BorderRadius.only(
        topRight: Radius.circular(defaultOuterRaduis),
      );

  static BorderRadius get bottomLeftOuter => BorderRadius.only(
        bottomLeft: Radius.circular(defaultOuterRaduis),
      );

  static BorderRadius get bottomRightOuter => BorderRadius.only(
        bottomRight: Radius.circular(defaultOuterRaduis),
      );

  /// - Inner
  static BorderRadius get topLeftInner => BorderRadius.only(
        topLeft: Radius.circular(defaultInnerRaduis),
      );

  static BorderRadius get topRightInner => BorderRadius.only(
        topRight: Radius.circular(defaultInnerRaduis),
      );

  static BorderRadius get bottomLeftInner => BorderRadius.only(
        bottomLeft: Radius.circular(defaultInnerRaduis),
      );

  static BorderRadius get bottomRightInner => BorderRadius.only(
        bottomRight: Radius.circular(defaultInnerRaduis),
      );
}