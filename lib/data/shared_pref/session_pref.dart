import 'package:compass_software/data/entity/distributor_code_entity.dart';

abstract interface class SessionPref {
  setLoggedIn(bool loggedIn);

  setAuthToken(String authToken);

  String getAuthToken();

  setRepId(String repId);

  String getRepId();

  setDistributorInfo(DistributorInfo info);

  DistributorInfo? getDistributorInfo();

  bool isLoggedIn();

  Future clear();

  setAutoCaptureEnabled(bool isEnabled);

  bool getAutoCaptureEnabled();
}
