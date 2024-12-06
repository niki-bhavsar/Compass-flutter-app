import 'package:compass_software/screens/settings/widget/setting_menu_card.dart';
import 'package:flutter/material.dart';
import '../model/setting_menu.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final List<SettingMenu> menus;

  const SettingCard({
    super.key,
    required this.menus,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          ListView.separated(
            itemCount: menus.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return SettingMenuCard(settingMenu: menus[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
