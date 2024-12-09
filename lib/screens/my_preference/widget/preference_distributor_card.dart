import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/distributor_code/distributor_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../data/entity/distributor_code_entity.dart';
import '../../../data/shared_pref/session_pref.dart';
import '../../../widget/app_dialog.dart';
import '../../../widget/svg_icons.dart';

class PreferenceDistributorCard extends StatelessWidget {
  const PreferenceDistributorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionPref = GetIt.instance.get<SessionPref>();
    DistributorInfo? info = sessionPref.getDistributorInfo();
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: ListTile(
        title: Row(
          children: [
            Text(
              info?.webName ?? "",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8.0),
              child: SvgIcon(
                SvgIcons.delete,
                size: 24,
                color: Theme.of(context).colorScheme.error,
              ),
            )
          ],
        ),
        onTap: () {
          AppDialog(
            title: info?.webName ?? "",
            message: context.l10n.myPreferenceScreen_removeDialog_message,
            positiveText: context.l10n.action_yes,
            negativeText: context.l10n.action_no,
            onPositiveClick: () {
              sessionPref.clear();
              context.navigateAndReplace(const DistributorCodeScreen());
            },
          ).show(context);
        },
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            context.l10n.myPreferenceScreen_distributor_info(info?.webName ?? ""),
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Theme.of(context).colorScheme.scrim, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
