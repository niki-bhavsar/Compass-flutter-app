import 'package:compass_software/data/entity/hospital_contact_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/hospital_contacts/hospital_contacts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widget/app_dialog.dart';

class HospitalContactsCard extends StatelessWidget {
  final HospitalContact hospitalContact;
  const HospitalContactsCard({
    super.key,
    required this.hospitalContact,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Card(
        child: ListTile(
          title: Text(
            hospitalContact.name,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: Text(
            hospitalContact.email,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
          trailing: GestureDetector(
            child: Container(
              alignment: Alignment.center,
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.remove,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            onTap: () {
              AppDialog(
                title: context.l10n.hospitalContactsScreen_title,
                message: context.l10n.hospitalContactsScreen_deleteContactsDialog_message,
                positiveText: context.l10n.action_ok,
                negativeText: context.l10n.action_cancel,
                onPositiveClick: () {
                  context.read<HospitalContactsCubit>().deleteHospitalContacts(hospitalContact.id);
                },
              ).show(context);
            },
          ),
        ),
      ),
    );
  }
}
