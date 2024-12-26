import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/surgeon_notes/widget/surgeon_notes_card_view.dart';
import 'package:compass_software/screens/profiles/surgeon_notes/widget/surgeon_notes_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../login/login_screen.dart';
import 'bloc/surgeon_notes_event.dart';
import 'bloc/surgeon_notes_state.dart';
import 'surgeon_notes_bloc.dart';

class SurgeonNotesScreen extends StatelessWidget {
  final String surgeonId;
  const SurgeonNotesScreen({
    super.key,
    required this.surgeonId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SurgeonNotesBloc(
        profilesRepository: context.read<ProfilesRepository>(),
        surgeonId: surgeonId,
      )..add(
          SurgeonNotesFetchEvent(),
        ),
      child: _HospitalNotesScaffold(),
    );
  }
}

class _HospitalNotesScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(context.l10n.hospitalNotesScreen_title),
        centerTitle: false,
      ),
      body: BlocConsumer<SurgeonNotesBloc, SurgeonNotesState>(
        listener: (context, state) {
          if (state is SurgeonNotesErrorState && state.isAuthError == true) {
            context.navigateAndReplace(const LoginScreen());
          }
        },
        builder: (context, state) {
          if (state is SurgeonNotesResultState) {
            return _SurgeonNotesList();
          } else {
            return SurgeonNotesStateView(
              state: state,
            );
          }
        },
      ),
    );
  }
}

class _SurgeonNotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SurgeonNotesBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        itemCount: bloc.surgeonNotesList.length,
        itemBuilder: (BuildContext context, int index) {
          return SurgeonNotesCardView(
            notesData: bloc.surgeonNotesList[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
