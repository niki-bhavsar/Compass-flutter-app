import 'package:compass_software/app/app_setup.dart';
import 'package:compass_software/data/shared_pref/session_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state/splash_state.dart';

class SplashBloc extends Cubit<SplashState> {
  final SessionPref sessionPref;

  SplashBloc({
    required this.sessionPref,
  }) : super(SplashInitialState());

  setup() async {
    // Post launch setup
    await appSetup.postLaunchSetup();

    // Check if user is logged in or not
    bool isLoggedIn = sessionPref.isLoggedIn();
    if (isLoggedIn) {
      // TODO: Check app version
    }

    bool isDistributorSaved = sessionPref.getDistributorInfo() != null;
    isLoggedIn = sessionPref.isLoggedIn();
    emit(SplashFetchedState(
      isLoggedIn: isLoggedIn,
      isDistributorSaved: isDistributorSaved,
    ));
  }
}
