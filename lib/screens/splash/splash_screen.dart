import 'package:compass_software/data/shared_pref/session_pref.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/distributor_code/distributor_code_screen.dart';
import 'package:compass_software/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_bloc.dart';
import 'state/splash_state.dart';
import 'widget/splash_app_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SplashBloc(
          sessionPref: context.read<SessionPref>(),
        )..setup(),
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashFetchedState) {
              if (!state.isDistributorSaved) {
                context.navigateAndReplace(const DistributorCodeScreen());
              } else if (state.isLoggedIn || state.isDistributorSaved) {
                context.navigateAndReplace(const LoginScreen());
              } else {
                context.navigateAndReplace(const DistributorCodeScreen());
              }
            }
          },
          child: const SplashAppLogo(),
        ),
      ),
    );
  }
}
