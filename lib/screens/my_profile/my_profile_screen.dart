import 'dart:async';

import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/my_profile/bloc/my_profile_state.dart';
import 'package:compass_software/screens/my_profile/widget/my_profile_state_view.dart';
import 'package:compass_software/screens/my_profile/widget/my_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/profile_repository.dart';
import '../login/login_screen.dart';
import 'bloc/my_profile_event.dart';
import 'my_profile_bloc.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyProfileBloc(
        profileRepository: context.read<ProfileRepository>(),
      )..add(StateListFetchEvent()),
      child: _MyProfileScaffold(),
    );
  }
}

class _MyProfileScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(context.l10n.settingsScreen_account_my_profile),
        centerTitle: false,
      ),
      body: BlocConsumer<MyProfileBloc, MyProfileState>(
        listener: (context, state) {
          if (state is MyProfileErrorState && state.isAuthError) {
            context.navigateAndReplace(const LoginScreen());
          } else if (state is MyProfileResultState && state.isEditProfile) {
            context.showSnackBar(state.message);
            Timer(const Duration(seconds: 1), () {
              Navigator.of(context).pop();
            });
          } else if (state is MyProfileFetchStatesListState) {
            context.read<MyProfileBloc>().add(UserProfileFetchEvent());
          }
        },
        builder: (context, state) {
          if (state is MyProfileResultState) {
            return const MyProfileView();
          } else {
            return MyProfileStateView(
              state: state,
            );
          }
        },
      ),
    );
  }
}
