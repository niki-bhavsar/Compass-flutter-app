import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/entity/hospital_contact_entity.dart';
import 'package:compass_software/data/entity/hospital_detail_entity.dart';
import 'package:compass_software/data/entity/notes_entity.dart';
import 'package:compass_software/data/entity/surgeon_detail_entity.dart';
import 'package:compass_software/data/entity/surgeon_entity.dart';
import 'package:compass_software/data/entity/surgeon_events_entity.dart';
import '../entity/hospital_entity.dart';
import 'base_service.dart';
import 'model/call_result.dart';

class ProfilesService extends BaseService {
  Future<CallResult<HospitalEntity>> getHospitalList() {
    final uri = toApiUri("gethospitallist");
    return safeGetApiCall<HospitalEntity>(
      uri: uri,
      jsonParser: hospitalEntityFromJson,
    );
  }

  Future<CallResult<HospitalDetailEntity>> getHospitalDetails(String hospitalId) {
    final uri = toApiUri("gethospitaldetail");
    final header = {"id": hospitalId};
    return safeGetApiCall<HospitalDetailEntity>(
      uri: uri,
      jsonParser: hospitalDetailEntityFromJson,
      headers: header,
    );
  }

  Future<CallResult<NotesEntity>> getHospitalNotes(String hospitalId) {
    final uri = toApiUri("gethospitalnotes");
    final header = {"id": hospitalId};
    return safeGetApiCall<NotesEntity>(
      uri: uri,
      jsonParser: notesEntityFromJson,
      headers: header,
    );
  }

  Future<CallResult<HospitalContactEntity>> getHospitalContacts(String hospitalId) {
    final uri = toApiUri("gethospitalcontact");
    final header = {"id": hospitalId};
    return safeGetApiCall<HospitalContactEntity>(
      uri: uri,
      jsonParser: hospitalContactEntityFromJson,
      headers: header,
    );
  }

  Future<CallResult<BaseEntity>> addHospitalContacts({
    required String hospitalId,
    required String name,
    required String email,
  }) async {
    final uri = toApiUri("addhospitalcontact");
    final params = {
      "name": name,
      "email": email,
    };
    final header = {"id": hospitalId};
    return safePostApiCall(
      uri: uri,
      headers: header,
      params: params,
      jsonParser: baseEntityFromJson,
    );
  }

  Future<CallResult<BaseEntity>> deleteHospitalContacts({
    required String hospitalId,
    required String contactId,
  }) async {
    final uri = toApiUri("deletehospitalcontact");

    final header = {"hid": hospitalId, "id": contactId};
    return safeDeleteApiCall(
      uri: uri,
      params: {},
      headers: header,
      jsonParser: baseEntityFromJson,
    );
  }

  Future<CallResult<SurgeonEntity>> getSurgeonList() {
    final uri = toApiUri("getsurgeonlist");
    return safeGetApiCall<SurgeonEntity>(
      uri: uri,
      jsonParser: surgeonEntityFromJson,
    );
  }

  Future<CallResult<SurgeonDetailEntity>> getSurgeonDetails(String surgeonId) {
    final uri = toApiUri("getsurgeondetail");
    final header = {"id": surgeonId};
    return safeGetApiCall<SurgeonDetailEntity>(
      uri: uri,
      jsonParser: surgeonDetailEntityFromJson,
      headers: header,
    );
  }

  Future<CallResult<NotesEntity>> getSurgeonNotes(String surgeonId) {
    final uri = toApiUri("getsurgeonnotes");
    final header = {"id": surgeonId};
    return safeGetApiCall<NotesEntity>(
      uri: uri,
      jsonParser: notesEntityFromJson,
      headers: header,
    );
  }

  Future<CallResult<SurgeonEventsEntity>> getSurgeonEvents(String surgeonId) {
    final uri = toApiUri("getsurgeonevents");
    final header = {"id": surgeonId};
    return safeGetApiCall<SurgeonEventsEntity>(
      uri: uri,
      jsonParser: surgeonEventsEntityFromJson,
      headers: header,
    );
  }
}
