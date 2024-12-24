import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/hospital_notes/widget/hospital_notes_card_view.dart';
import 'package:compass_software/screens/profiles/hospital_notes/widget/hospital_notes_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../login/login_screen.dart';
import 'bloc/hospital_notes_event.dart';
import 'bloc/hospital_notes_state.dart';
import 'hospital_notes_bloc.dart';

class HospitalNotesScreen extends StatelessWidget {
  final String hospitalId;
  const HospitalNotesScreen({
    super.key,
    required this.hospitalId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HospitalNotesBloc(
        profilesRepository: context.read<ProfilesRepository>(),
        hospitalId: hospitalId,
      )..add(
          HospitalsNotesFetchEvent(),
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
      body: BlocConsumer<HospitalNotesBloc, HospitalNotesState>(
        listener: (context, state) {
          if (state is HospitalNotesErrorState && state.isAuthError == true) {
            context.navigateAndReplace(const LoginScreen());
          }
        },
        builder: (context, state) {
          if (state is HospitalNotesResultState) {
            return _HospitalNotesList();
          } else {
            return HospitalNotesStateView(
              state: state,
            );
          }
        },
      ),
    );
  }
}

class _HospitalNotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HospitalNotesBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        itemCount: bloc.hospitalNotesList.length,
        itemBuilder: (BuildContext context, int index) {
          return HospitalNotesCardView(
            notesData: bloc.hospitalNotesList[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
