import 'package:compass_software/data/entity/surgeon_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/surgeon_profile/widget/surgeon_profile_state_view.dart';
import 'package:compass_software/screens/profiles/surgeon_profile/widget/surgeon_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../login/login_screen.dart';
import 'bloc/surgeon_profile_event.dart';
import 'bloc/surgeon_profile_state.dart';
import 'surgeon_profile_bloc.dart';

class SurgeonProfileScreen extends StatelessWidget {
  final SurgeonData surgeon;
  const SurgeonProfileScreen({
    super.key,
    required this.surgeon,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SurgeonProfileBloc(
        profilesRepository: context.read<ProfilesRepository>(),
      )..add(
          SurgeonProfileFetchEvent(surgeon.surgeonId),
        ),
      child: _SurgeonProfileScaffold(
        surgeon: surgeon,
      ),
    );
  }
}

class _SurgeonProfileScaffold extends StatelessWidget {
  final SurgeonData surgeon;

  const _SurgeonProfileScaffold({required this.surgeon});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocConsumer<SurgeonProfileBloc, SurgeonProfileState>(
        listener: (context, state) {
          if (state is SurgeonProfileErrorState && state.isAuthError == true) {
            context.navigateAndReplace(const LoginScreen());
          } else if (state is SurgeonProfileResultState) {
            context.read<SurgeonProfileBloc>().add(SurgeonProfileEventsFetch(surgeon.surgeonId));
          }
        },
        builder: (context, state) {
          if (state is SurgeonEventsResultState) {
            return const SurgeonProfileView();
          } else {
            return SurgeonProfileStateView(
              state: state,
            );
          }
        },
      ),
    );
  }
}
