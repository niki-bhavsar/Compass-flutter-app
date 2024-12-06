import 'package:compass_software/data/entity/distributor_code_entity.dart';

abstract interface class SessionPref {
  setLoggedIn(bool loggedIn);

  setAuthToken(String authToken);

  String getAuthToken();

  setDistributorInfo(DistributorInfo info);

  DistributorInfo? getDistributorInfo();

  bool isLoggedIn();

  Future clear();
}
