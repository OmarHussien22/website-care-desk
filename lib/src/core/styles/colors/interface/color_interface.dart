import 'package:coursaty/src/core/utils/extensions/color_extension.dart';
import 'package:flutter/material.dart';

import '../../../../flavors/flavor_holder.dart';

abstract class ColorInterface {
// TODO 6 : Add Basic Colors here !
  Color get primarySwatch => const Color(0xff9D0708);
  

  Color get primary => FlavorHolder.instance.flavor.primaryColor;
  Color get primaryOpactity =>
      FlavorHolder.instance.flavor.primaryColor.toOpacityColor(0.04);

  Color get primaryDarker => FlavorHolder.instance.flavor.secondaryColor;

  Color get secondary => FlavorHolder.instance.flavor.secondaryColor;

  Color get allQuestion => const Color(0xff5071EB);
  Color get labany => const Color(0xffE5EDFF);
  Color get third => const Color(0xff9CA0BC);
  Color get tabBarUnselectedTab => const Color(0xffF7F7F7);
  Color get currentExam => const Color(0xff5071EB);
  Color get bankExamLight => const Color(0xff5071EB);
  Color get bankExamDark => const Color(0xff2D4085);
  Color get pastExam => const Color(0xff378E8B);
  Color get missedExam => const Color(0xffF53B5F);
  Color get enableBorderColor => const Color(0xffD9DBE9);
  Color get textFieldHintColor => const Color(0xff546881);

  Color get lightText => third;

  Color get buttonSecondary => third;

  Color get buttonMain => main;

  Color get icon;

  Color get switchEnabled => const Color(0xff4CD964);

  Color get switchDisabled => const Color(0xffF7F8FA);

  Color get switchBorder => const Color(0xffE5E5E5);

  Color get cardBorder;

  Color get cardFill;

  Color get buttonText => third;

  Color get main;

  Color get black => Colors.black87;
  Color get lightBlack => Color(0xff202020);

  /// ------------------------ grey --------------------------
  Color get background;
  Color get primaryBackground => const Color(0xffE7F3EB);
  Color get scaffoldBackground => const Color(0xffFAFAFA);

  Color get tabBar;

  Color get activeBackground;

  Color get orangeLight => const Color(0xffff8216);
  Color get storeTitle => const Color(0xff003A00);
  Color get red1 => const Color(0xffE23535);
  Color get green => const Color(0xff4CAF50);

  /// ------------------------ grey --------------------------

  Color get greyText => const Color(0xFF4B5563);

  Color get greyText1 => const Color(0xff6B7280);

  Color get grey => const Color(0xFF4B5563);
  Color get grey1 => const Color(0xffF8F9FA);
  Color get grey2 => const Color(0xffF1F3F5);
  Color get staticsCardBorder => const Color(0xffFAFAFA);

  Color get darkGrey => const Color(0xff525356);
  Color get darkGrey2 => const Color(0xff546881);
  Color get grey3 => const Color(0xff9CA3AF);
  Color get grey4 => const Color(0xff888F9B);
  Color get darkGrey4 => const Color(0xff3D4C5E);
  Color get dividerColor => const Color(0xffF3F3F3);
  Color get textFieldColor => const Color(0xffD9DBE9);

  Color get tabsTextColor => const Color(0xff6B7280);

  Color get featuresTextColor => const Color(0xff4B5563);

  Color get mediumGrey => const Color(0xff4B5563);
  Color get mediumGrey2 => const Color(0xff6B7280);
  Color get mediumGrey3 => const Color(0xff6B7280);
  Color get mediumGrey4 => const Color(0xffF2F2F2);
  Color get lighterGrey => const Color(0xffFCFCFC);

  Color get containerBordersColor => const Color(0xffF8F8F8);
  Color get totalPriceContainerColor => const Color(0xffE7F3EB);
  Color get personalizedCourseCard => const Color(0xffF4F4F4);

  Color get secondaryColor => const Color(0xffFCF5E5);
  Color get lightGrey => const Color(0xff6B7280);
  Color get lightGrey2 => const Color(0xffEBEBEB);
  Color get lightGrey3 => const Color(0xffFBFBFB);
  Color get mapBorderColor => const Color(0xffF0F0F0);
  Color get facebookColor => const Color(0xff1877F2);
  Color get instagramColor => const Color(0xffFA9905);
  Color get youtubeColor => const Color(0xffFF4040);
  Color get ticktokColor => const Color(0xff10162E);
  Color get twitterColor => const Color(0xff202020);

  Color get opposite;

  /// for disabled item like buttons
  Color get disabled;

  Color get title;

  Color get subTitle => const Color(0xffACB1C0);

  Color get tFFFill;

  Color get indicatorActive => secondary;

  Color get indicatorInactive => const Color(0xffE7F3EB);

  Color get appbar => main;

  Color get appbarTitle => primaryDarker;

  Color get appBarColorInner;

  Color get shadow;

  Color get white => Colors.white;
  Color get white2 => Color(0xffFCFCFC);

  Color get white3 => Color(0xffF6F6F6);
  Color get white4 => Color(0xffF0FFF5);
  Color get white5 => Color(0xffEDEDED);
  Color get white7 => Color(0xffFFFFFF);

  Color get opacityWhite => const Color(0xffF6F8FE);
  Color get testBankPageBG => const Color(0xffFBFBFB);

  Color get transparent => Colors.transparent;

  Color get red => const Color(0xffFF2C2C);
  Color get error => red;

  Color get caution => const Color(0xffFF2D55);

  Color get amber => const Color(0xffFFB116);

  Color get orange => const Color(0xffFF9113);
  Color get orange2 => const Color(0xffCA8A04);

  Color get yellow => const Color(0xffFCD732);

  Color get chipFill => main;

  Color get chipBorderSecondary => const Color(0xffDFEDFC);

  Color get titleTestExamBG => const Color(0xffE7F3EB);
  Color get mainContainerTestBankBG => const Color(0xffFCFCFC);

  Color get chipBorder => const Color(0xff101C43);

  Color get userCircleAvatarFill => primary;

  Color get circleAvatarFill => const Color(0xffEFF7FF);

  Color get circleAvatarOverlay => Colors.white.toOpacityColor(0.5);

  Color get circleAvatarBorder => Colors.white;

  Color get circleAvatarStackedBorder => const Color(0xff3D4CDB);

  Color get bookValueItemcolor => const Color(0xff4B5563);

  Color get booktitleItemcolor => const Color(0xff9CA3AF);
  Color get rightArrowContainerBackground => const Color(0xffE7F3EB);

  Color get blue => Colors.blue;
  Color get blueSec => Color(0xff25387A);
  Color get lightBlue => Color(0xff25387A);

  Color get circleBorder => const Color(0xff939393);

  Color get cardSubTitle => const Color(0xffC2C2C2);

  Color get cardBackGroundAccount => const Color(0xffF5F6F7);

  Color get cardBorderColor => const Color(0xffC1C1C1);
  Color get subjectBackgroundCard => const Color(0xffF7F7F7);

  /// changed to grade // or save as image
  Color get bnbSelectedItem => primary;

  Color get bnbUnSelectedItem => const Color(0xff949494);

  Color get onRefreshIndicator;

//<editor-fold desc="Text Field">
  Color get tTFCursor => const Color(0xff000000);

  Color get tTFFillColor => Colors.transparent;

  Color get tFFInputTitle => const Color(0xff000000);

  Color get tFFInputBackground => Colors.transparent;

  Color get tTFIsRequired => red;

  Color get tTFPrefixColor => darkGrey;

  Color get tTFPrefixText => const Color(0xffFEF1F1);

  Color get tTFErrorBorder => Colors.red;

  Color get tTFErrorText => const Color(0xffFF4947);

  Color get tTFErrorTextBcg => transparent; //Color(0xffFEF1F1);

  Color get tFFHintTitle => grey;

  Color get tTFHintTextBcg => const Color(0xffFEF1F1);

  Color get tFFHeaderTitle => title;

  Color get tFFHeaderBackground => Colors.transparent;

  Color get tFFLabelTitle => title;

  Color get tFFLabelBackground => const Color(0xffBBBDC1);

  Color get tTFBackGround => Colors.transparent;

  Color get tTFActiveBackGround => const Color(0xFFF5F5F5);

  Color get tTFFocusBorder => primary;

  Color get tTFSuffixIcon => darkGrey;
  Color get tTFEnableBorder => const Color(0xffE6E6E6);

  Color get tTFDisableBorder => grey1;

  Color get tFFSuffixText => const Color(0xffFEF1F1);
  Color get darkblue => const Color(0xff25387A);
  Color get darkBlue2 => const Color(0xff1E293B);
  Color get darkBlue3 => const Color(0xff3D4C5E);
}
