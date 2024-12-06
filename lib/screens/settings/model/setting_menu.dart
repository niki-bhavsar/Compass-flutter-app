import 'package:flutter/material.dart';

class SettingMenu {
  final String title;
  final IconData icon;
  final ValueChanged<BuildContext> onTap;

  const SettingMenu({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
