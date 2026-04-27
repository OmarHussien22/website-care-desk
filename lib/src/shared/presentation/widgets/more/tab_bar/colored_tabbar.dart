import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:flutter/material.dart';

class ColoredTabBar extends Container implements PreferredSizeWidget {
  final TabBar tabBar;

  final Color? color;

  ColoredTabBar({Key? key, this.color, required this.tabBar}) : super(key: key);

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) =>
      Container(height: 48.toH(), color: color, child: tabBar);
}
