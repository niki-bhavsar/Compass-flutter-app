import 'package:compass_software/data/entity/user_profile_entity.dart';

import '../entity/base_entity.dart';
import '../entity/change_password_entity.dart';
import '../entity/state_entity.dart';
import '../service/model/call_result.dart';
import '../service/profile_service.dart';
import '../shared_pref/session_pref.dart';

abstract interface class ProfileRepository {
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

base class ProfileRepositoryImpl implements ProfileRepository {
  final SessionPref sessionPref;
  final ProfileService profileService;

  ProfileRepositoryImpl({
    required this.sessionPref,
    required this.profileService,
  });

  @override
  Future<CallResult<ChangePasswordEntity>> changePassword(
    String currentPassword,
    String newPassword,
  ) {
    return profileService.changePassword(
      currentPassword,
      newPassword,
    );
  }

  @override
  Future<CallResult<StateEntity>> getStateList() {
    return profileService.getStateList();
  }

  @override
  Future<CallResult<UserProfileEntity>> getRepUserProfile() {
    return profileService.getRepUserProfile();
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
    return profileService.saveRepUserProfile(
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
