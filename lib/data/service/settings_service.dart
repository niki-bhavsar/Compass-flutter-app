import 'package:compass_software/data/entity/announcement_entity.dart';
import 'package:compass_software/data/entity/technique_library_entity.dart';
import 'package:compass_software/data/service/base_service.dart';
import 'package:compass_software/data/service/model/call_result.dart';

class SettingsService extends BaseService {
  Future<CallResult<AnnouncementsEntity>> getAnnouncements() {
    final uri = toApiUri("getannouncements");
    return safeGetApiCall(
      uri: uri,
      jsonParser: announcementsEntityFromJson,
    );
  }

  Future<CallResult<TechniqueLibraryEntity>> getTechniqueLibraries() {
    final uri = toApiUri("gettechniques");
    return safeGetApiCall(
      uri: uri,
      jsonParser: techniqueLibraryEntityFromJson,
    );
  }
}
