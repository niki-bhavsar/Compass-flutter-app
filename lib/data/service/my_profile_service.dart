import 'package:compass_software/data/entity/state_entity.dart';
import '../entity/base_entity.dart';
import '../entity/change_password_entity.dart';
import '../entity/user_profile_entity.dart';
import 'base_service.dart';
import 'model/call_result.dart';

class MyProfileService extends BaseService {
  Future<CallResult<ChangePasswordEntity>> changePassword(
    String currentPassword,
    String newPassword,
  ) {
    final uri = toApiUri("changepassword");
    final params = {
      "old_password": currentPassword,
      "new_password": newPassword,
    };
    return safePutApiCall(
      uri: uri,
      params: params,
      jsonParser: changePasswordEntityFromJson,
    );
  }

  Future<CallResult<StateEntity>> getStateList() {
    final uri = toApiUri("statelist");
    return safeGetApiCall<StateEntity>(
      uri: uri,
      jsonParser: stateEntityFromJson,
    );
  }

  Future<CallResult<UserProfileEntity>> getRepUserProfile() {
    final uri = toApiUri("repprofile");
    return safeGetApiCall<UserProfileEntity>(
      uri: uri,
      jsonParser: userProfileEntityFromJson,
    );
  }

  Future<CallResult<BaseEntity>> saveRepUserProfile({
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String zip,
    required String cellNumber,
    required String phoneNumber,
    required String faxNumber,
    required String accountNumber,
    required String contactInfo,
  }) {
    final uri = toApiUri("saverepprofile");
    final params = {
      "address1": address1,
      "address2": address2,
      "city": city,
      "state": state,
      "zip": zip,
      "cell": cellNumber,
      "phone": phoneNumber,
      "fax": faxNumber,
      "account_number": accountNumber,
      "contract_info": contactInfo,
    };
    return safePutApiCall<BaseEntity>(
      uri: uri,
      params: params,
      jsonParser: baseEntityFromJson,
    );
  }
}
