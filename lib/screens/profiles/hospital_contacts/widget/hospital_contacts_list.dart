import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../login/login_screen.dart';
import '../bloc/hospital_contacts_state.dart';
import '../hospital_contacts_cubit.dart';
import 'hospital_contact_state_view.dart';
import 'hospital_contacts_card.dart';

class HospitalContactList extends StatelessWidget {
  const HospitalContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HospitalContactsCubit, HospitalContactsState>(
      listener: (context, state) {
        if (state is HospitalContactsErrorState && state.isAuthError) {
          context.navigateAndReplace(const LoginScreen());
        }
      },
      builder: (context, state) {
        final bloc = context.read<HospitalContactsCubit>();
        if (state is HospitalContactsListResultState && bloc.hospitalContactsList.isNotEmpty) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            itemCount: bloc.hospitalContactsList.length,
            itemBuilder: (BuildContext context, int index) {
              return HospitalContactsCard(
                hospitalContact: bloc.hospitalContactsList[index],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
          );
        } else {
          return HospitalContactStateView(
            state: state,
          );
        }
      },
    );
  }
}
