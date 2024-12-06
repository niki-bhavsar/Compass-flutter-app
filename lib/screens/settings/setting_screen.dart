import 'package:compass_software/data/repository/auth_repository.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/firebase/analytics.dart';
import 'package:compass_software/screens/distributor_code/distributor_code_screen.dart';
import 'package:compass_software/screens/settings/state/setting_event.dart';
import 'package:compass_software/widget/app_dialog.dart';
import 'package:compass_software/widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'model/setting_menu.dart';
import 'setting_bloc.dart';
import 'state/setting_state.dart';
import 'widget/setting_menu_card.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final List<SettingMenu> accountsMenus = <SettingMenu>[
      SettingMenu(
        title: context.l10n.settingsScreen_account_my_preference,
        icon: Icons.document_scanner_outlined,
        onTap: (context) {},
      ),
      SettingMenu(
        title: context.l10n.settingsScreen_account_my_profile,
        icon: Icons.account_circle_outlined,
        onTap: (context) {},
      ),
      SettingMenu(
        title: context.l10n.settingsScreen_account_change_password,
        icon: Icons.lock_outline,
        onTap: (context) {},
      ),
    ];
     final List<SettingMenu> favouriteMenus = <SettingMenu>[
       SettingMenu(
         title: context.l10n.settingsScreen_favourite_surgeon,
         icon: Icons.document_scanner_outlined,
         onTap: (context) {},
       ),
       SettingMenu(
         title: context.l10n.settingsScreen_favourite_hospital,
         icon: Icons.document_scanner_outlined,
         onTap: (context) {},
       ),
       SettingMenu(
         title: context.l10n.settingsScreen_favourite_procedure,
         icon: Icons.document_scanner_outlined,
         onTap: (context) {},
       ),
     ];

     final List<SettingMenu> reportMenus = <SettingMenu>[
       SettingMenu(
         title: context.l10n.settingsScreen_reports_backorder_report,
         icon: Icons.document_scanner_outlined,
         onTap: (context) {},
       ),
       SettingMenu(
         title: context.l10n.settingsScreen_reports_sales_snapshot,
         icon: Icons.attach_money_outlined,
         onTap: (context) {},
       ),
     ];

     final List<SettingMenu> generalMenus = <SettingMenu>[
       SettingMenu(
         title: context.l10n.settingsScreen_general_manage_templates,
         icon: Icons.document_scanner_outlined,
         onTap: (context) {},
       ),
       SettingMenu(
         title: context.l10n.settingsScreen_general_technique_library,
         icon:  Icons.campaign_outlined,
         onTap: (context) {},
       ),
       SettingMenu(
         title: context.l10n.settingsScreen_general_announcement,
         icon: Icons.campaign_outlined,
         onTap: (context) {},
       ),
       SettingMenu(
         title: context.l10n.settingsScreen_general_logout,
         icon: Icons.logout_rounded,
         onTap: (context) {
           // Log event
           AnalyticsEvent.logout.logEvent();

           AppDialog(
             title: context.l10n.settingsScreen_general_logout,
             message: context.l10n.settingsScreen_logoutDialog_message,
             positiveText: context.l10n.action_ok,
             negativeText: context.l10n.action_cancel,
             onPositiveClick: () {
               context.read<SettingBloc>().add(SettingLogoutClickEvent());
             },
           ).show(context);
         },
       )
     ];
     Map<String, List<SettingMenu>> getSettingMenus() {
       Map<String, List<SettingMenu>> menus = {};
       menus[context.l10n.settingsScreen_account_title] = accountsMenus;
       menus[context.l10n.settingsScreen_favourite_title] = favouriteMenus;
       menus[context.l10n.settingsScreen_reports_title] = reportMenus;
       menus[context.l10n.settingsScreen_general_title] = generalMenus;
       return menus;
     }
    var menus = getSettingMenus();
    var menuKeys = menus.keys.toList();

    // UI Widgets
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(context.l10n.settingsScreen_title),
        centerTitle: false,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: BlocProvider(
        create: (_) => SettingBloc(
          authRepository: context.read<AuthRepository>(),
        ),
        child: BlocConsumer<SettingBloc, SettingState>(
          listenWhen: (previous, current) {
            return current is SettingLogoutState;
          },
          listener: (context, state) {
            // TODO: It depends...
            context.navigateAndReplace(const DistributorCodeScreen());
          },
          builder: (context, state) {
            return ProgressView(
              isLoading: state is SettingLoadingState,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: menus.length,
                itemBuilder: (BuildContext context, int index) {
                  var title = menuKeys[index];
                  var list = menus[menuKeys[index]];
                  return _SettingCard(
                    title: title,
                    menus: list ?? [],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SettingCard extends StatelessWidget {
  final String title;
  final List<SettingMenu> menus;

  const _SettingCard({
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
                  color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600
              ),
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
