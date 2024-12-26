import 'package:compass_software/data/entity/surgeon_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/surgeon_profile/surgeon_profile_screen.dart';
import 'package:flutter/material.dart';
import '../../../../widget/svg_icons.dart';

class SurgeonCard extends StatelessWidget {
  final SurgeonData surgeon;

  const SurgeonCard({
    super.key,
    required this.surgeon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 3),
        // to expand
        title: Text(
          surgeon.title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        //TODO: commented this because we don't have account number in getsurgeonlist api
        // subtitle: Text(
        //   "subtitle",
        //   style: Theme.of(context).textTheme.labelMedium?.copyWith(
        //       fontWeight: FontWeight.w300, color: Theme.of(context).colorScheme.inverseSurface),
        // ),
        leading: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8.0),
          child: SvgIcon(
            SvgIcons.surgeon,
            size: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        trailing: const Icon(Icons.navigate_next_rounded),
        onTap: () {
          context.navigate(SurgeonProfileScreen(surgeon: surgeon));
        },
      ),
    );
  }
}
