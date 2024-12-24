import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import '../profiles/profiles_screen/profiles_screen.dart';

class BottomMenuScreen extends StatefulWidget {
  const BottomMenuScreen({super.key});

  @override
  State<BottomMenuScreen> createState() => _BottomMenuScreenState();
}

class _BottomMenuScreenState extends State<BottomMenuScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      useDrawer: false,
      selectedIndex: _selectedTab,
      onSelectedIndexChange: (int index) {
        setState(() {
          _selectedTab = index;
        });
      },
      internalAnimations: false,
      destinations: <NavigationDestination>[
        NavigationDestination(
          icon: const _NavigationIcon(icon: Icons.event_rounded),
          selectedIcon: const _NavigationIcon(icon: Icons.event_outlined),
          label: context.l10n.bottomMenuScreen_tabSchedule_title,
        ),
        NavigationDestination(
          icon: const _NavigationIcon(icon: Icons.account_circle_outlined),
          selectedIcon: const _NavigationIcon(icon: Icons.account_circle_rounded),
          label: context.l10n.bottomMenuScreen_tabProfiles_title,
        ),
        NavigationDestination(
          icon: const _NavigationIcon(icon: Icons.paid_outlined),
          selectedIcon: const _NavigationIcon(icon: Icons.paid_rounded),
          label: context.l10n.bottomMenuScreen_tabSales_title,
        ),
        NavigationDestination(
          icon: const _NavigationIcon(icon: Icons.settings_outlined),
          selectedIcon: const _NavigationIcon(icon: Icons.settings),
          label: context.l10n.bottomMenuScreen_tabSettings_title,
        ),
      ],
      body: (_) => _selectedPage(),
      smallBody: (_) => _selectedPage(),
    );
  }

  Widget _selectedPage() {
    switch (_selectedTab) {
      case 1:
        return const ProfilesScreen();
      case 2:
        return const Placeholder();
      case 3:
        return const SettingScreen();
      default:
        return const Placeholder();
    }
  }
}

class _NavigationIcon extends StatelessWidget {
  final IconData icon;

  const _NavigationIcon({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 24,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
