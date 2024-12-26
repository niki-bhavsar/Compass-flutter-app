import 'package:compass_software/data/entity/hospital_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/hospital_profile/bloc/hospital_profile_state.dart';
import 'package:compass_software/screens/profiles/hospital_profile/widget/hospital_profile_state_view.dart';
import 'package:compass_software/screens/profiles/hospital_profile/widget/hospital_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../login/login_screen.dart';
import 'bloc/hospital_profile_event.dart';
import 'hospital_profile_bloc.dart';

class HospitalProfileScreen extends StatelessWidget {
  final HospitalData hospital;
  const HospitalProfileScreen({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HospitalProfileBloc(
        profilesRepository: context.read<ProfilesRepository>(),
      )..add(HospitalsProfileFetchEvent(hospital.hospitalId)),
      child: _HospitalProfileScaffold(),
    );
  }
}

class _HospitalProfileScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocConsumer<HospitalProfileBloc, HospitalProfileState>(
        listener: (context, state) {
          if (state is HospitalProfileErrorState && state.isAuthError == true) {
            context.navigateAndReplace(const LoginScreen());
          }
        },
        builder: (context, state) {
          if (state is HospitalNotesResultState) {
            return const HospitalProfileView();
          } else {
            return HospitalProfileStateView(
              state: state,
            );
          }
        },
      ),
    );
  }
}
