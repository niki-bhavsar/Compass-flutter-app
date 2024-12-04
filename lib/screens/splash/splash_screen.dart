import 'package:compass_software/data/shared_pref/session_pref.dart';
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
              // context.navigateAndReplace(state.route);
            }
          },
          child: const SplashAppLogo(),
        ),
      ),
    );
  }
}
