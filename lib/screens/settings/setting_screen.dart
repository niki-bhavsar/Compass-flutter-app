import 'package:compass_software/data/repository/auth_repository.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/firebase/analytics.dart';
import 'package:compass_software/screens/announcements/announcements_screen.dart';
import 'package:compass_software/screens/change_password/change_password_screen.dart';
import 'package:compass_software/screens/my_preference/my_preference_screen.dart';
import 'package:compass_software/screens/my_profile/my_profile_screen.dart';
import 'package:compass_software/screens/settings/state/setting_event.dart';
import 'package:compass_software/screens/settings/widget/setting_card.dart';
import 'package:compass_software/screens/technique_library/technique_library_screen.dart';
import 'package:compass_software/widget/app_dialog.dart';
import 'package:compass_software/widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../data/shared_pref/session_pref.dart';
import '../../widget/svg_icons.dart';
import '../login/login_screen.dart';
import 'model/setting_menu.dart';
import 'setting_bloc.dart';
import 'state/setting_state.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SettingMenu> accountsMenus = <SettingMenu>[
      SettingMenu(
        title: context.l10n.settingsScreen_account_my_preference,
        svgIcon: SvgIcons.myPreference,
        onTap: (context) {
          context.navigate(const MyPreferenceScreen());
        },
      ),
      SettingMenu(
        title: context.l10n.settingsScreen_account_my_profile,
        svgIcon: SvgIcons.myProfile,
        onTap: (context) {
          context.navigate(const MyProfileScreen());
        },
      ),
      SettingMenu(
        title: context.l10n.settingsScreen_account_change_password,
        svgIcon: SvgIcons.changePassword,
        onTap: (context) {
          context.navigate(const ChangePasswordScreen());
        },
      ),
    ];
    final List<SettingMenu> favouriteMenus = <SettingMenu>[
      SettingMenu(
        title: context.l10n.settingsScreen_favourite_surgeon,
        svgIcon: SvgIcons.surgeon,
        onTap: (context) {},
      ),
      SettingMenu(
        title: context.l10n.settingsScreen_favourite_hospital,
        svgIcon: SvgIcons.hospital,
        onTap: (context) {},
      ),
      SettingMenu(
        title: context.l10n.settingsScreen_favourite_procedure,
        svgIcon: SvgIcons.procedure,
        onTap: (context) {},
      ),
    ];
    final List<SettingMenu> reportMenus = <SettingMenu>[
      SettingMenu(
        title: context.l10n.settingsScreen_reports_backorder_report,
        svgIcon: SvgIcons.backOrder,
        onTap: (context) {},
      ),
      SettingMenu(
        title: context.l10n.settingsScreen_reports_sales_snapshot,
        svgIcon: SvgIcons.salesSnapshot,
        onTap: (context) {},
      ),
    ];
    final List<SettingMenu> generalMenus = <SettingMenu>[
      SettingMenu(
        title: context.l10n.settingsScreen_general_manage_templates,
        svgIcon: SvgIcons.manageTemplates,
        onTap: (context) {},
      ),
      SettingMenu(
        title: context.l10n.settingsScreen_general_technique_library,
        svgIcon: SvgIcons.techniqueLibrary,
        onTap: (context) {
          context.navigate(const TechniqueLibraryScreen());
        },
      ),
      SettingMenu(
        title: context.l10n.settingsScreen_general_announcement,
        svgIcon: SvgIcons.announcement,
        onTap: (context) {
          context.navigate(const AnnouncementsScreen());
        },
      ),
      SettingMenu(
        title: context.l10n.settingsScreen_general_logout,
        svgIcon: SvgIcons.logout,
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
            final sessionPref = GetIt.instance.get<SessionPref>();
            sessionPref.setLoggedIn(false);
            context.navigateAndReplace(const LoginScreen());
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
                  return SettingCard(
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
