import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/hospital_contacts/bloc/hospital_contacts_state.dart';
import 'package:compass_software/screens/profiles/hospital_contacts/hospital_contacts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';

class HospitalContactStateView extends StatelessWidget {
  final HospitalContactsState state;

  const HospitalContactStateView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is HospitalContactsLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is HospitalContactsErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          context.read<HospitalContactsCubit>().getHospitalContacts();
        },
      );
    }

    return StateView(
      title: context.l10n.hospitalContactsScreen_title,
      message: context.l10n.hospitalContactsScreen_no_data_message,
    );
  }
}
