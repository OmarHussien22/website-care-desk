import 'package:flutter/material.dart';
import '../../../app/meddesk_config.dart';

import '../../../utils/extensions/color_extension.dart';

abstract class ColorInterface {
  // TODO 6 : Add Basic Colors here !
  Color get primarySwatch => MedDeskConfig.primaryColor;

  // Color get primary => const Color(0xff93518B);
  // Color get primary => const Color(0xff3F44DC);
  Color get primary => MedDeskConfig.primaryColor;

  Color get lightPrimary => const Color(0xff4245a8);

  Color get lightCard => const Color(0xffF8F3F8);

  Color get primaryDarker => const Color(0xff4E0049);

  Color get secondary => MedDeskConfig.secondaryColor;

  Color get third => const Color(0xff9CA0BC);

  /// Text Colors
  Color get lightText => lightBlue;
  Color get titleText => const Color(0xff333333);
  Color get subtitleText => const Color(0xff909DAD);
  Color get cardTitleText => const Color(0xff0B1741);
  Color get cardsubTitleText => const Color(0xff47586E);

  /// background color
  Color get cardBackground => const Color(0xFFF2F2F2);
  Color get chatCardBackground => const Color(0xFFFBFBFD);
  Color get appbarBackground => primary;
  Color get primaryCardBackground => const Color(0xffF3F6FF);
  Color get imageCardBackground => const Color(0xffEDF2F8);

  Color get buttonSecondary => third;

  Color get buttonMain => main;

  Color get icon;

  Color get switchEnabled => const Color(0xff4CD964);

  Color get switchDisabled => const Color(0xffF7F8FA);

  Color get switchBorder => const Color(0xffE5E5E5);

  Color get cardBorder => const Color(0xffEDF2F8);

  Color get cardFill;

  Color get buttonText => third;

  Color get main;

  Color get black => Colors.black87;

  Color get background;

  Color get tabBar;

  Color get activeBackground;

  Color get orangeLight => const Color(0xffff8216);

  /// Grey Colors
  Color get greyLight => const Color(0xffD9D9D9);
  Color get grey => const Color(0xff6C7278);
  Color get darkGrey => const Color(0xff525356);
  Color get lighterGrey => const Color(0xffF3F3F5);

  Color get lightPink => const Color(0xffE1D0D6);

  Color get secondaryColor => const Color(0xffFCF5E5);

  Color get opposite => Colors.black;

  /// for disabled item like buttons
  Color get disabled;

  Color get title;

  Color get subTitle => const Color(0xffACB1C0);
  Color get hintTitle => const Color(0xffA3ADBB);
  Color get lightBlue => const Color(0xff546881);

  Color get indicatorActive => secondary;

  Color get indicatorInactive => const Color(0xffCCCCCC);

  Color get appbar => main;

  Color get appbarTitle => primaryDarker;
  Color get appBarColorInner;

  Color get shadow;

  Color get white => Colors.white;

  Color get transparent => Colors.transparent;

  Color get red => const Color(0xffF44336);
  Color get lightRed => const Color(0xffFCF3F3);
  Color get darkRed => const Color(0xffc00000);

  Color get error => const Color(0xffE23535);

  Color get caution => const Color(0xffFF2D55);

  Color get green => const Color(0xff38D826);
  Color get success => const Color(0xff4AB272);

  Color get amber => const Color(0xffFFB116);

  Color get orange => const Color(0xffF17A25);

  Color get yellow => const Color(0xffFCD732);

  Color get chipFill => main;

  Color get tableHeaderColor => const Color(0xffDCE2EE);
  Color get tableBodyColor => const Color(0xffEFF2FF);
  Color get chipBorderSecondary => const Color(0xffDFEDFC);

  Color get chipBorder => const Color(0xff101C43);

  Color get userCircleAvatarFill => primary;

  Color get circleAvatarFill => const Color(0xffEFF7FF);

  Color get circleAvatarOverlay => Colors.white.toOpacityColor(0.5);

  Color get circleAvatarBorder => Colors.white;

  Color get circleAvatarStackedBorder => const Color(0xff3D4CDB);

  Color get blue => const Color(0xff9DDCEC);
  Color get darkBlue => const Color(0xff0E1E55);
  Color get kLightBlue => const Color(0xffEDF6FF);
  Color get kLightBlue2 => const Color(0xffF6F8FF);

  Color get circleBorder => const Color(0xff939393);

  Color get cardSubTitle => const Color(0xffC2C2C2);

  Color get cardBackGroundAccount => const Color(0xffECECEC);

  Color get cardBorderColor => const Color(0xffF0F1F4);
  Color get primaryLighter => const Color(0xffF8F3F8);

  Color get rateColor => const Color(0xffEDA807);
  Color get dateColor => const Color(0xff8D8D8D);
  Color get tabBarlUnselectedTab => const Color(0xffF7F7F7);
  Color get tabBarlUnselectedLable => const Color(0xff858585);
  Color get searchBar => const Color(0xffBFC1C3);
  Color get filterWord => const Color(0xff666C8E);
  Color get disActiveDot => const Color(0xffBDBDBD);

  /// changed to grade // or save as image
  Color get bnbSelectedItem => primary;

  Color get bnbUnSelectedItem => const Color(0xff949494);

  Color get onRefreshIndicator;

  //<editor-fold desc="Text Field">
  Color get tFFFillColor => Colors.white;

  Color get tTFCursor => const Color(0xff000000);

  Color get tFFInputTitle => const Color(0xff000000);

  Color get tFFInputBackground => Colors.transparent;

  Color get tTFIsRequired => red;

  Color get tTFPrefixColor => greyLight;

  Color get tTFPrefixText => const Color(0xffFEF1F1);

  Color get tTFErrorBorder => Colors.red;

  Color get tTFErrorText => const Color(0xffFF4947);

  Color get tTFErrorTextBcg => const Color(0xffFEF1F1);

  Color get tFFHintTitle => lightBlue;

  Color get tTFHintTextBcg => const Color(0xffFEF1F1);

  Color get tFFHeaderTitle => title;

  Color get tFFHeaderBackground => Colors.transparent;

  Color get tFFLabelTitle => lightBlue;

  Color get tFFLabelBackground => transparent;

  Color get tTFBackGround => Colors.transparent;

  Color get tTFActiveBackGround => const Color(0xFFF5F5F5);

  Color get tTFBorder => primary;
  Color get tTFGreyBorder => Color(0xffECEDF0);

  Color get tTFFocusBorder => primary;

  Color get tTFSuffixIcon => const Color(0xffB2BBC6);

  Color get tTFEnableBorder => cardBorder;

  Color get tTFDisableBorder => cardBorder;

  Color get tFFSuffixText => const Color(0xffFEF1F1);

  //</editor-fold>

  // ---------------------- Landing-specific tokens ----------------------
  Color get surfaceMuted;
  Color get surfaceElevated;
  Color get borderSubtle;
  Color get accentGradientStart;
  Color get accentGradientEnd;
  Color get textPrimary;
  Color get textSecondary;
  Color get textInverse;

  LinearGradient get defaultLinearColor => LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    transform: const GradientRotation(-0.5),
    colors: linearColors,
  );

  List<Color> get linearColors => [primary, Color(0xff0D47A1)];
}
