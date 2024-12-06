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
    required String username,
    required String password,
  }) async {
    CallResult<LoginEntity> response = await authService.login(username, password);
    if (response is Success<LoginEntity>) {
      final user = response.data.loginUserInfo;
      if (user != null) {
        sessionPref.setLoggedIn(true);
        sessionPref.setAuthToken(user.authToken);
      }

      // write logic to save access token
    }
    return response;
  }

  @override
  Future<CallResult<BaseEntity>> checkAppVersion() {
    return authService.checkAppVersion();
  }

  @override
  Future<CallResult<BaseEntity>> logout() async {
    final response = await authService.logout();
    if (response is Success<BaseEntity>) {
      sessionPref.setLoggedIn(false);
      //TODO: on distributor remove we have to remove distributor info also
    }
    return response;
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
