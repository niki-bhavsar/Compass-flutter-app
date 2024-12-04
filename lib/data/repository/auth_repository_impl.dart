import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/entity/login_entity.dart';
import 'package:compass_software/data/service/auth_service.dart';
import 'package:compass_software/data/service/model/call_result.dart';
import 'package:compass_software/data/shared_pref/session_pref.dart';

import '../entity/distributor_code_entity.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;
  final SessionPref sessionPref;

  AuthRepositoryImpl({
    required this.authService,
    required this.sessionPref,
  });

  @override
  bool isLoggedIn() => sessionPref.isLoggedIn();

  @override
  Future<CallResult<LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    CallResult<LoginEntity> response = await authService.login(email, password);
    if (response is Success<LoginEntity>) {
      sessionPref.setLoggedIn(true);
      // write logic to save access token
    }
    return response;
  }

  @override
  Future<CallResult<BaseEntity>> checkAppVersion() {
    return authService.checkAppVersion();
  }

  @override
  void logout() {
    sessionPref.clear();
  }

  @override
  Future<CallResult<DistributorEntity>> verifyDistributorCode({
    required String code,
  }) async {
    CallResult<DistributorEntity> response = await authService.verifyDistributorCode(code);
    if (response is Success<DistributorEntity>) {
      final distributor = response.data.distributorInfo;
      if (distributor != null) {
        sessionPref.setDistributorInfo(distributor);
      }
    }
    return response;
  }
}
