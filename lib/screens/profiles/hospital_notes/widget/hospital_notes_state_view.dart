import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/hospital_notes/hospital_notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../bloc/hospital_notes_event.dart';
import '../bloc/hospital_notes_state.dart';

class HospitalNotesStateView extends StatelessWidget {
  final HospitalNotesState state;

  const HospitalNotesStateView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is HospitalNotesLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is HospitalNotesErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          context.read<HospitalNotesBloc>().add(HospitalsNotesFetchEvent());
        },
      );
    }

    return StateView(
      title: context.l10n.hospitalProfilesScreen_notes_tab,
      message: context.l10n.hospitalContactsScreen_no_data_message,
    );
  }
}
