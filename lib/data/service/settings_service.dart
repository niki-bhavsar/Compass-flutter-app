import 'package:compass_software/data/entity/announcement_entity.dart';
import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/entity/technique_library_entity.dart';
import 'package:compass_software/data/entity/template_implant_instrument_filtercategory.dart';
import 'package:compass_software/data/entity/template_implants_intrument_entity.dart';
import 'package:compass_software/data/entity/template_kits_detail_entiry.dart';
import 'package:compass_software/data/entity/templates_list_entity.dart';
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

  Future<CallResult<TemplateListEntity>> getTemplatesList() {
    final uri = toApiUri("templatelist");
    return safeGetApiCall<TemplateListEntity>(
      uri: uri,
      jsonParser: templateListEntityFromJson,
    );
  }

  Future<CallResult<TemplateImplantInstrumentEntity>> getDefaultImplantsInstruments() {
    final uri = toApiUri("schedulekitsform");
    return safeGetApiCall<TemplateImplantInstrumentEntity>(
      uri: uri,
      jsonParser: templateImplantInstrumentEntityFromJson,
    );
  }

  Future<CallResult<TemplateImplantInstrumentFiltercategory>> getImplantsInstrumentsforCategory(
      String parentId, String childId) {
    final uri = toApiUri("categorykits");
    return safeGetApiCall<TemplateImplantInstrumentFiltercategory>(
        uri: uri,
        jsonParser: templateImplantInstrumentFiltercategoryFromJson,
        headers: {"mainid": parentId, "subid": childId});
  }

  Future<CallResult<ImplantInstrumentEditTemplateEntity>> getImplantsInstrumentsforTemplate(
      String templateID) {
    final uri = toApiUri("templatekits");
    final result = safeGetApiCall<ImplantInstrumentEditTemplateEntity>(
        uri: uri,
        jsonParser: implantInstrumentEditTemplateEntity,
        headers: {"TEMPLATEID": templateID});
    return result;
  }

  Future<CallResult<TemplateKitsDetailEntiry>> getKitsDetails(String kitId) {
    final uri = toApiUri("kitdetails");
    return safeGetApiCall<TemplateKitsDetailEntiry>(
        uri: uri, jsonParser: kitsDetailFromJson, headers: {"kitid": kitId});
  }

  Future<CallResult<BaseEntity>> createEditTemplate(
      String? templateID, String templateName, List<String>? implant, List<String>? instruments) {
    final uri = toApiUri("savetemplate");
    if (templateID == null) {
      return safePostApiCall<BaseEntity>(
          uri: uri,
          jsonParser: baseEntityFromJson,
          params: {"template_name": templateName, "implant": implant, "instrument": instruments});
    }
    return safePutApiCall<BaseEntity>(uri: uri, jsonParser: baseEntityFromJson, params: {
      "template_id": templateID,
      "template_name": templateName,
      "implant": implant,
      "instrument": instruments
    });
  }
}
