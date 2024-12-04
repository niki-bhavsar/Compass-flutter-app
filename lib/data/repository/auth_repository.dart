import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/entity/login_entity.dart';
import 'package:compass_software/data/service/model/call_result.dart';

abstract interface class AuthRepository {
  bool isLoggedIn();

  Future<CallResult<LoginEntity>> login({
    required String email,
    required String password,
  });

  Future<CallResult<BaseEntity>> checkAppVersion();

  void logout();
}
