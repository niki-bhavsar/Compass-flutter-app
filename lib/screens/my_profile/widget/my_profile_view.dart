import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/my_profile/bloc/my_profile_event.dart';
import 'package:compass_software/screens/my_profile/my_profile_bloc.dart';
import 'package:compass_software/screens/my_profile/widget/my_profile_address_view.dart';
import 'package:compass_software/screens/my_profile/widget/my_profile_contact_info_view.dart';
import 'package:compass_software/screens/my_profile/widget/my_profile_personal_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _MyProfileFormView(
            key: UniqueKey(),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: () {
              context.read<MyProfileBloc>().add(UserProfileSaveEvent());
            },
            child: Text(context.l10n.action_update),
          ),
        )
      ],
    );
  }
}

class _MyProfileFormView extends StatefulWidget {
  const _MyProfileFormView({super.key});

  @override
  State<_MyProfileFormView> createState() => _MyProfileFormViewState();
}

class _MyProfileFormViewState extends State<_MyProfileFormView> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MyProfileBloc>();
    return Form(
      key: bloc.formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const <Widget>[
          SizedBox(height: 16),
          MyProfilePersonalInfoView(),
          SizedBox(height: 16),
          MyProfileAddressView(),
          SizedBox(height: 16),
          MyProfileContactInfoView()
        ],
      ),
    );
  }
}
