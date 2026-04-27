import 'package:turnable_page/turnable_page.dart';

/// Configuration wrapper for [TurnablePage] / [TurnablePdf] widgets.
///
/// Use one of the named constructors for common presets, or configure
/// every parameter explicitly via the default constructor.
class TurnablePageConfig {
  final int startPageIndex;
  final bool drawShadow;

  /// Flip animation duration in milliseconds.
  final int flippingTime;
  final bool usePortrait;
  final double maxShadowOpacity;
  final bool showCover;
  final double swipeDistance;
  final bool showPageCorners;
  final double cornerTriggerAreaSize;
  final PageViewMode pageViewMode;

  /// Returns the effective mode based on screen size (double for tablets).
  PageViewMode effectiveMode(bool isTablet) =>
      isTablet ? PageViewMode.double : pageViewMode;

  final PaperBoundaryDecoration paperBoundaryDecoration;

  const TurnablePageConfig({
    this.startPageIndex = 0,
    this.drawShadow = true,
    this.flippingTime = 450,
    this.usePortrait = true,
    this.maxShadowOpacity = 0.5,
    this.showCover = true,
    this.swipeDistance = 30.0,
    this.showPageCorners = true,
    this.cornerTriggerAreaSize = 60.0,
    this.pageViewMode = PageViewMode.single,
    this.paperBoundaryDecoration = PaperBoundaryDecoration.modern,
  });

  /// Portrait, vintage paper, deep shadow — classic book feel.
  const TurnablePageConfig.book()
      : startPageIndex = 0,
        drawShadow = true,
        flippingTime = 600,
        usePortrait = true,
        maxShadowOpacity = 0.7,
        showCover = true,
        swipeDistance = 30.0,
        showPageCorners = true,
        cornerTriggerAreaSize = 70.0,
        pageViewMode = PageViewMode.single,
        paperBoundaryDecoration = PaperBoundaryDecoration.vintage;

  /// Double-page spread, modern style, fast flip — magazine feel.
  const TurnablePageConfig.magazine()
      : startPageIndex = 0,
        drawShadow = true,
        flippingTime = 300,
        usePortrait = false,
        maxShadowOpacity = 0.4,
        showCover = true,
        swipeDistance = 20.0,
        showPageCorners = true,
        cornerTriggerAreaSize = 50.0,
        pageViewMode = PageViewMode.double,
        paperBoundaryDecoration = PaperBoundaryDecoration.modern;

  /// No shadow, no corners, very fast flip — for UI-heavy / interactive content.
  const TurnablePageConfig.minimal()
      : startPageIndex = 0,
        drawShadow = false,
        flippingTime = 200,
        usePortrait = true,
        maxShadowOpacity = 0.0,
        showCover = false,
        swipeDistance = 15.0,
        showPageCorners = false,
        cornerTriggerAreaSize = 40.0,
        pageViewMode = PageViewMode.single,
        paperBoundaryDecoration = PaperBoundaryDecoration.modern;

  /// Converts this config into a [FlipSettings] instance for the package.
  FlipSettings toFlipSettings() {
    return FlipSettings(
      startPageIndex: startPageIndex,
      drawShadow: drawShadow,
      flippingTime: flippingTime,
      usePortrait: usePortrait,
      maxShadowOpacity: maxShadowOpacity,
      showCover: showCover,
      swipeDistance: swipeDistance,
      showPageCorners: showPageCorners,
      cornerTriggerAreaSize: cornerTriggerAreaSize,
    );
  }

  TurnablePageConfig copyWith({
    int? startPageIndex,
    bool? drawShadow,
    int? flippingTime,
    bool? usePortrait,
    double? maxShadowOpacity,
    bool? showCover,
    double? swipeDistance,
    bool? showPageCorners,
    double? cornerTriggerAreaSize,
    PageViewMode? pageViewMode,
    PaperBoundaryDecoration? paperBoundaryDecoration,
  }) {
    return TurnablePageConfig(
      startPageIndex: startPageIndex ?? this.startPageIndex,
      drawShadow: drawShadow ?? this.drawShadow,
      flippingTime: flippingTime ?? this.flippingTime,
      usePortrait: usePortrait ?? this.usePortrait,
      maxShadowOpacity: maxShadowOpacity ?? this.maxShadowOpacity,
      showCover: showCover ?? this.showCover,
      swipeDistance: swipeDistance ?? this.swipeDistance,
      showPageCorners: showPageCorners ?? this.showPageCorners,
      cornerTriggerAreaSize: cornerTriggerAreaSize ?? this.cornerTriggerAreaSize,
      pageViewMode: pageViewMode ?? this.pageViewMode,
      paperBoundaryDecoration:
          paperBoundaryDecoration ?? this.paperBoundaryDecoration,
    );
  }
}
