import 'package:compass_software/data/entity/distributor_code_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'session_pref.dart';

class SessionPrefImpl implements SessionPref {
  static const String _isLoggedIn = 'profile.is_logged_in';
  static const String _webID = 'session.web_id';
  static const String _webName = 'session.web_name';
  static const String _webDBSuffix = 'session.webDBSuffix';
  static const String _logoUrl = 'session.logo_url';

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

  @override
  DistributorInfo? getDistributorInfo() {
    // TODO: implement getDistributorInfo
  }

  @override
  setDistributorInfo(DistributorInfo info) {
    prefs.setString(_webID, info.webId);
    prefs.setString(_webName, info.webName);
    prefs.setString(_webDBSuffix, info.webDBSuffix);
    prefs.setString(_logoUrl, info.logoUrl);
  }
}
