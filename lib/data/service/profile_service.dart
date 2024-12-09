import '../entity/change_password_entity.dart';
import 'base_service.dart';
import 'model/call_result.dart';

class ProfileService extends BaseService {
  Future<CallResult<ChangePasswordEntity>> changePassword(
    String currentPassword,
    String newPassword,
  ) {
    final uri = toApiUri("changepassword");
    final params = {
      "old_password": currentPassword,
      "new_password": newPassword,
    };
    return safePutApiCall(uri: uri, params: params, jsonParser: changePasswordEntityFromJson);
  }
}
