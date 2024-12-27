import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';
import '../notes_bloc.dart';

class NotesStateView extends StatelessWidget {
  final NotesState state;

  const NotesStateView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is NotesLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is NotesErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          context.read<NotesBloc>().add(NotesFetchEvent());
        },
      );
    }

    return StateView(
      title: context.l10n.hospitalProfilesScreen_notes,
      message: context.l10n.hospitalContactsScreen_no_data_message,
    );
  }
}
