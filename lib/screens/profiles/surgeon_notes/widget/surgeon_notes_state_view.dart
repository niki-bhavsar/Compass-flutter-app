import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../bloc/surgeon_notes_event.dart';
import '../bloc/surgeon_notes_state.dart';
import '../surgeon_notes_bloc.dart';

class SurgeonNotesStateView extends StatelessWidget {
  final SurgeonNotesState state;

  const SurgeonNotesStateView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is SurgeonNotesLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is SurgeonNotesErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          context.read<SurgeonNotesBloc>().add(SurgeonNotesFetchEvent());
        },
      );
    }

    return StateView(
      title: context.l10n.surgeonProfilesScreen_notes,
      message: context.l10n.hospitalContactsScreen_no_data_message,
    );
  }
}
