import 'package:compass_software/data/entity/distributor_code_entity.dart';

abstract interface class SessionPref {
  setLoggedIn(bool loggedIn);

  setDistributorInfo(DistributorInfo info);

  DistributorInfo? getDistributorInfo();

  bool isLoggedIn();

  Future clear();
}
