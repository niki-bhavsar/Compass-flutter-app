import 'package:compass_software/widget/svg_icons.dart';
import 'package:flutter/material.dart';
import '../model/setting_menu.dart';

class SettingMenuCard extends StatelessWidget {
  final SettingMenu settingMenu;

  const SettingMenuCard({super.key, required this.settingMenu});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      title: Text(
        settingMenu.title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.navigate_next_rounded),
      leading: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8.0),
        child: SvgIcon(
          settingMenu.svgIcon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      onTap: () {
        settingMenu.onTap(context);
      },
    );
  }
}
