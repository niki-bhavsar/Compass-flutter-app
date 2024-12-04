import 'package:shared_preferences/shared_preferences.dart';

import 'session_pref.dart';

class SessionPrefImpl implements SessionPref {
  static const String _isLoggedIn = 'profile.is_logged_in';

  final SharedPreferences prefs;

  SessionPrefImpl(this.prefs);

  @override
  setLoggedIn(bool loggedIn) {
    prefs.setBool(_isLoggedIn, loggedIn);
  }

  @override
  bool isLoggedIn() => prefs.getBool(_isLoggedIn) ?? false;

  @override
  Future clear() async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    await prefs1.remove(_isLoggedIn);
    await prefs1.reload();

    await prefs.remove(_isLoggedIn);
    await prefs.reload();
  }
}
