import '../entity/change_password_entity.dart';
import '../service/model/call_result.dart';
import '../service/profile_service.dart';
import '../shared_pref/session_pref.dart';

abstract interface class ProfileRepository {
  Future<CallResult<ChangePasswordEntity>> changePassword(
    String currentPassword,
    String newPassword,
  );
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
    return profileService.changePassword(currentPassword, newPassword);
  }
}
