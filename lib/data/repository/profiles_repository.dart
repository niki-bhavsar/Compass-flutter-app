import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/entity/hospital_notes_entity.dart';
import 'package:compass_software/data/entity/surgeon_entity.dart';
import '../entity/hospital_contact_entity.dart';
import '../entity/hospital_detail_entity.dart';
import '../entity/hospital_entity.dart';
import '../entity/surgeon_detail_entity.dart';
import '../entity/surgeon_notes_entity.dart';
import '../service/model/call_result.dart';
import '../service/profiles_service.dart';
import '../shared_pref/session_pref.dart';

abstract interface class ProfilesRepository {
  Future<CallResult<HospitalEntity>> getHospitalList();
  Future<CallResult<HospitalDetailEntity>> getHospitalDetails(String hospitalId);
  Future<CallResult<HospitalNotesEntity>> getHospitalNotes(String hospitalId);
  Future<CallResult<HospitalContactEntity>> getHospitalContacts(String hospitalId);
  Future<CallResult<BaseEntity>> addHospitalContacts({
    required String hospitalId,
    required String name,
    required String email,
  });

  Future<CallResult<BaseEntity>> deleteHospitalContacts({
    required String hospitalId,
    required String contactId,
  });

  Future<CallResult<SurgeonEntity>> getSurgeonList();
  Future<CallResult<SurgeonDetailEntity>> getSurgeonDetails(String surgeonID);
  Future<CallResult<SurgeonNotesEntity>> getSurgeonNotes(String surgeonID);
}

base class ProfilesRepositoryImpl implements ProfilesRepository {
  final SessionPref sessionPref;
  final ProfilesService profilesService;

  ProfilesRepositoryImpl({
    required this.sessionPref,
    required this.profilesService,
  });

  @override
  Future<CallResult<HospitalEntity>> getHospitalList() {
    return profilesService.getHospitalList();
  }

  @override
  Future<CallResult<HospitalDetailEntity>> getHospitalDetails(String hospitalId) {
    return profilesService.getHospitalDetails(hospitalId);
  }

  @override
  Future<CallResult<HospitalNotesEntity>> getHospitalNotes(String hospitalId) {
    return profilesService.getHospitalNotes(hospitalId);
  }

  @override
  Future<CallResult<HospitalContactEntity>> getHospitalContacts(String hospitalId) {
    return profilesService.getHospitalContacts(hospitalId);
  }

  @override
  Future<CallResult<BaseEntity>> addHospitalContacts({
    required String hospitalId,
    required String name,
    required String email,
  }) async {
    return profilesService.addHospitalContacts(
      hospitalId: hospitalId,
      name: name,
      email: email,
    );
  }

  @override
  Future<CallResult<BaseEntity>> deleteHospitalContacts({
    required String hospitalId,
    required String contactId,
  }) async {
    return profilesService.deleteHospitalContacts(
      hospitalId: hospitalId,
      contactId: contactId,
    );
  }

  @override
  Future<CallResult<SurgeonEntity>> getSurgeonList() {
    return profilesService.getSurgeonList();
  }

  @override
  Future<CallResult<SurgeonDetailEntity>> getSurgeonDetails(String surgeonId) {
    return profilesService.getSurgeonDetails(surgeonId);
  }

  @override
  Future<CallResult<SurgeonNotesEntity>> getSurgeonNotes(String surgeonID) {
    return profilesService.getSurgeonNotes(surgeonID);
  }
}
