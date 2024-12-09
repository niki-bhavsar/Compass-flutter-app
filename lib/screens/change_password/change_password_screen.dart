import 'dart:async';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/change_password/widget/change_password_form_view.dart';
import 'package:compass_software/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/profile_repository.dart';
import '../../widget/progress.dart';
import 'bloc/change_password_state.dart';
import 'change_password_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(context.l10n.settingsScreen_account_change_password),
        centerTitle: false,
      ),
      body: BlocProvider(
        create: (_) => ChangePasswordBloc(
          profileRepository: context.read<ProfileRepository>(),
        ),
        child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordErrorState && state.isAuthError) {
              context.navigateAndReplace(const LoginScreen());
            }
            if (state is ChangePasswordResultState) {
              context.showSnackBar(state.changePasswordEntity.message ?? "");
              Timer(const Duration(seconds: 1), () {
                Navigator.of(context).pop();
              });
            }
            if (state is ChangePasswordErrorState) {
              context.showSnackBar(state.error);
            }
          },
          builder: (context, state) {
            return ProgressView(
              isLoading: state is ChangePasswordLoadingState,
              child: const ChangePasswordView(),
            );
          },
        ),
      ),
    );
  }
}
