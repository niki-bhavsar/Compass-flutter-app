import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class HospitalProfileGeneralCardView extends StatelessWidget {
  const HospitalProfileGeneralCardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text("Jhon Deo",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                )),
        subtitle: Text(
          "aa@bca.com",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const Divider(),
          Row(
            children: [
              Text.rich(TextSpan(
                  text: context.l10n.hospitalProfilesScreen_general_tab_role,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.outline),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Nurse',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSurface),
                    )
                  ])),
              const Spacer(),
              Text.rich(TextSpan(
                  text: context.l10n.hospitalProfilesScreen_general_tab_type,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.outline),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Staff',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSurface),
                    )
                  ])),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text.rich(TextSpan(
                  text: context.l10n.hospitalProfilesScreen_general_tab_phone,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.outline),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '999-999-9999',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSurface),
                    )
                  ])),
              const Spacer(),
              Text.rich(TextSpan(
                  text: context.l10n.hospitalProfilesScreen_general_tab_cell,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.outline),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '999-999-9999',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSurface),
                    )
                  ])),
            ],
          ),
          const SizedBox(height: 8),
          Text(context.l10n.hospitalProfilesScreen_general_tab_notes,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
          const SizedBox(height: 2),
          Text(
              "Porem ipsum dolor sit amet, consectetur adipiscing elit.Porem ipsum dolor Porem ipsum ",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  )),
          const Divider(),
          IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(
                  height: 32,
                  // color: Colors.red,
                  width: (MediaQuery.sizeOf(context).width - 90) / 2,
                  child: TextButton(
                    child: Text(context.l10n.action_edit.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            )),
                    onPressed: () {},
                  ),
                ),

                // Spacer(),
                const VerticalDivider(
                  thickness: 1,
                ),

                // Spacer(),
                SizedBox(
                  height: 32,
                  // color: Colors.red,
                  width: (MediaQuery.sizeOf(context).width - 90) / 2,
                  child: TextButton(
                    child: Text(context.l10n.action_delete.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.error)),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
