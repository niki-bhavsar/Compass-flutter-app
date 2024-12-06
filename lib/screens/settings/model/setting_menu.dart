import 'package:compass_software/widget/svg_icons.dart';
import 'package:flutter/material.dart';

class SettingMenu {
  final String title;
  final SvgIcons svgIcon;
  final ValueChanged<BuildContext> onTap;

  const SettingMenu({
    required this.title,
    required this.svgIcon,
    required this.onTap,
  });
}
