import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/phone_number_formatter.dart';
import '../my_profile_bloc.dart';

class MyProfileContactInfoView extends StatelessWidget {
  const MyProfileContactInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    String? cellNumberValidator(String? text) {
      if (text!.isNotEmpty && text.length != 12) {
        return context.l10n.myProfileScreen_cell_number_invalidError;
      }
      return null;
    }

    String? phoneNumberValidator(String? text) {
      if (text!.isNotEmpty && text.length != 12) {
        return context.l10n.myProfileScreen_phone_number_invalidError;
      }
      return null;
    }

    String? faxNumberValidator(String? text) {
      if (text!.isNotEmpty && text.length != 12) {
        return context.l10n.myProfileScreen_fax_number_invalidError;
      }
      return null;
    }

    final bloc = context.read<MyProfileBloc>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.myProfileScreen_contact_info_title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.cellNumberController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_cell_number_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              validator: cellNumberValidator,
              inputFormatters: [
                LengthLimitingTextInputFormatter(12),
                FilteringTextInputFormatter.digitsOnly,
                PhoneNumberInputFormatter(),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.phoneNumberController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_phone_number_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: phoneNumberValidator,
              inputFormatters: [
                LengthLimitingTextInputFormatter(12),
                FilteringTextInputFormatter.digitsOnly,
                PhoneNumberInputFormatter(),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.faxNumberController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_fax_number_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: faxNumberValidator,
              inputFormatters: [
                LengthLimitingTextInputFormatter(12),
                FilteringTextInputFormatter.digitsOnly,
                PhoneNumberInputFormatter(),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.accountNumberController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_account_number_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.contactInfoController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_contact_info_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
          ],
        ),
      ),
    );
  }
}
