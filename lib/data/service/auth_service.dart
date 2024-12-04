import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/entity/distributor_code_entity.dart';
import 'package:compass_software/data/entity/login_entity.dart';

import 'base_service.dart';
import 'model/call_result.dart';

class AuthService extends BaseService {

  Future<CallResult<LoginEntity>> login(
    String email,
    String password,
  ) {
    final params = <String, String>{};
    params["email"] = email;
    params["password"] = password;

    final uri = toApiUri("login");
    return safePostApiCall<LoginEntity>(
      uri: uri,
      jsonParser: loginEntityFromJson,
      params: params,
    );
  }

  Future<CallResult<BaseEntity>> checkAppVersion() {
    final params = <String, String>{};
    final uri = toApiUri("checkappversion");
    return safePostApiCall<BaseEntity>(
      uri: uri,
      jsonParser: baseEntityFromJson,
      params: params,
    );
  }

  Future<CallResult<DistributorCodeEntity>> setDistributorCode(
      String code
      ) {
    final params = <String, String>{};
    params["app_code"] = code;

    final uri = toApiUri("setdistributor");
    return safePostApiCall<DistributorCodeEntity>(
      uri: uri,
      jsonParser: distributorCodeEntityFromJson,
      params: params,
    );
  }
}
