import 'package:compass_software/data/entity/user_profile_entity.dart';

import '../entity/base_entity.dart';
import '../entity/change_password_entity.dart';
import '../entity/state_entity.dart';
import '../service/model/call_result.dart';
import '../service/my_profile_service.dart';
import '../shared_pref/session_pref.dart';

abstract interface class MyProfileRepository {
  Future<CallResult<ChangePasswordEntity>> changePassword(
    String currentPassword,
    String newPassword,
  );
  Future<CallResult<StateEntity>> getStateList();

  Future<CallResult<UserProfileEntity>> getRepUserProfile();

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
  });
}

base class MyProfileRepositoryImpl implements MyProfileRepository {
  final SessionPref sessionPref;
  final MyProfileService myProfileService;

  MyProfileRepositoryImpl({
    required this.sessionPref,
    required this.myProfileService,
  });

  @override
  Future<CallResult<ChangePasswordEntity>> changePassword(
    String currentPassword,
    String newPassword,
  ) {
    return myProfileService.changePassword(
      currentPassword,
      newPassword,
    );
  }

  @override
  Future<CallResult<StateEntity>> getStateList() {
    return myProfileService.getStateList();
  }

  @override
  Future<CallResult<UserProfileEntity>> getRepUserProfile() {
    return myProfileService.getRepUserProfile();
  }

  @override
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
  }) async {
    return myProfileService.saveRepUserProfile(
        address1: address1,
        address2: address2,
        city: city,
        state: state,
        zip: zip,
        cellNumber: cellNumber,
        phoneNumber: phoneNumber,
        faxNumber: faxNumber,
        accountNumber: accountNumber,
        contactInfo: contactInfo);
  }
}
