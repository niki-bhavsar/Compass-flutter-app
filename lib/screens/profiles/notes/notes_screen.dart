import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/notes/widget/notes_card_view.dart';
import 'package:compass_software/screens/profiles/notes/widget/notes_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../login/login_screen.dart';
import 'bloc/notes_event.dart';
import 'bloc/notes_state.dart';
import 'notes_bloc.dart';

class NotesScreen extends StatelessWidget {
  final String id;
  final bool isSurgeon;
  const NotesScreen({
    super.key,
    required this.id,
    required this.isSurgeon,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesBloc(
        profilesRepository: context.read<ProfilesRepository>(),
        id: id,
        isSurgeon: isSurgeon,
      )..add(
          NotesFetchEvent(),
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
      body: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesErrorState && state.isAuthError == true) {
            context.navigateAndReplace(const LoginScreen());
          }
        },
        builder: (context, state) {
          if (state is NotesResultState) {
            return _NotesList();
          } else {
            return NotesStateView(
              state: state,
            );
          }
        },
      ),
    );
  }
}

class _NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NotesBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        itemCount: bloc.notesList.length,
        itemBuilder: (BuildContext context, int index) {
          return NotesCardView(
            notesData: bloc.notesList[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
