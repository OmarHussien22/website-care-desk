import 'package:coursaty/src/core/styles/colors/app_colors.dart';
import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/lang/translate_extention.dart';
import '../../general_widgets/image/generic_image/generic_image.dart';
import 'custom_bottom_nav_item.dart';

class DefaultBottomNavItem {
  DefaultBottomNavItem._();

  static BottomNavigationBarItem defaultBottomNavItem({
    required String label,  
    required String image,
    required String activeImage,
    int count = 0,
  }) {
    return BottomNavigationBarItem(
      icon: Badge.count(
        count: count,
        isLabelVisible: count > 0,
        child: CustomBottomNavItem(
          image: image,
          size: 20,
          color: AppColors.get.bnbUnSelectedItem,
          label: label,
        ),
      ),
      activeIcon: Badge.count(
        count: count,
        isLabelVisible: count > 0,
        child: CustomBottomNavItem(
          image: activeImage.isNotEmpty ? activeImage : image,
          size: 18,
          color: AppColors.get.bnbSelectedItem,
          label: label,
        ),
      ),
      label: label.toTr(),
    );
  }

  static BottomNavigationBarItem bottomNavItemIcon({
    required String label,
    required IconData icon,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: AppColors.get.bnbUnSelectedItem,
        size: 20.toH(),
        semanticLabel: label.toTr(),
      ),
      activeIcon: Icon(
        icon,
        size: 18.toH(),
        color: AppColors.get.bnbSelectedItem,
        semanticLabel: label.toTr(),
      ),
      label: label.toTr(),
    );
  }
}
