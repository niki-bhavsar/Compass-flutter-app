import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/hospital_contacts/widget/hospital_contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../../utils/text_util.dart';
import 'hospital_contacts_cubit.dart';

class HospitalContactsScreen extends StatelessWidget {
  final String hospitalId;
  const HospitalContactsScreen({
    super.key,
    required this.hospitalId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HospitalContactsCubit(
        profilesRepository: context.read<ProfilesRepository>(),
        hospitalId: hospitalId,
      )..getHospitalContacts(),
      child: _HospitalContactsScaffold(),
    );
  }
}

class _HospitalContactsScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.hospitalContactsScreen_title),
        centerTitle: false,
      ),
      body: _HospitalContactsTopView(),
    );
  }
}

class _HospitalContactsTopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? nameValidator(String? text) {
      if (text!.isEmpty) {
        return context.l10n.hospitalContactsScreen_name_validation;
      }
      return null;
    }

    String? emailValidator(String? text) {
      if (text!.isEmpty) {
        return context.l10n.hospitalContactsScreen_email_validation;
      } else if (!TextUtil.isValidEmail(text)) {
        return context.l10n.hospitalContactsScreen_errorInvalidEmail_message;
      }
      return null;
    }

    final bloc = context.read<HospitalContactsCubit>();
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Form(
              key: bloc.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: bloc.nameController,
                    decoration: InputDecoration(
                      labelText: context.l10n.hospitalContactsScreen_name_hint,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textInputAction: TextInputAction.next,
                    validator: nameValidator,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: bloc.emailController,
                    decoration: InputDecoration(
                      labelText: context.l10n.hospitalContactsScreen_email_hint,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textInputAction: TextInputAction.next,
                    validator: emailValidator,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        context.read<HospitalContactsCubit>().addHospitalContacts();
                      },
                      child: Text(context.l10n.hospitalContactsScreen_add_contact_button),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Expanded(
          child: HospitalContactList(),
        )
      ],
    );
  }
}
