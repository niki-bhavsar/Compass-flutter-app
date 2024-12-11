import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../my_profile_bloc.dart';

class MyProfilePersonalInfoView extends StatelessWidget {
  const MyProfilePersonalInfoView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MyProfileBloc>();
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.myProfileScreen_personal_info_title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.userNameController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_user_name_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.next,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.firstNameController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_first_name_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.next,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.lastNameController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_last_name_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.next,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.groupController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_group_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.next,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.emailController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_email_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.next,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.wwidController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_wwid_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.next,
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
