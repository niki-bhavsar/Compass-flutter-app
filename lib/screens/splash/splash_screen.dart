import 'package:compass_software/data/shared_pref/session_pref.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/bottom_menu/bottom_menu_screen.dart';
import 'package:compass_software/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../distributor_code/distributor_code_screen.dart';
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
              } else if (state.isDistributorSaved && state.isLoggedIn) {
                // TODO: Before GO LIVE, Modify this to redirect on Login screen even if already loggd in
                context.navigateAndReplace(const BottomMenuScreen());
              } else {
                context.navigateAndReplace(const LoginScreen());
              }
            }
          },
          child: const SplashAppLogo(),
        ),
      ),
    );
  }
}
