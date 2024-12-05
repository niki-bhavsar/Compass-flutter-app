import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/entity/login_entity.dart';
import 'package:compass_software/data/service/model/call_result.dart';

import '../entity/distributor_code_entity.dart';

abstract interface class AuthRepository {
  bool isLoggedIn();

  Future<CallResult<LoginEntity>> login({
    required String username,
    required String password,
  });

  Future<CallResult<BaseEntity>> checkAppVersion();

  void logout();

  Future<CallResult<DistributorEntity>> verifyDistributorCode({
    required String code,
  });
}
