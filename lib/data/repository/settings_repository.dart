import 'package:compass_software/data/entity/announcement_entity.dart';
import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/entity/technique_library_entity.dart';
import 'package:compass_software/data/entity/template_implant_instrument_filtercategory.dart';
import 'package:compass_software/data/entity/template_implants_intrument_entity.dart';
import 'package:compass_software/data/entity/template_kits_detail_entiry.dart';
import 'package:compass_software/data/entity/templates_list_entity.dart';
import 'package:compass_software/data/service/model/call_result.dart';
import 'package:compass_software/data/service/settings_service.dart';
import 'package:compass_software/data/shared_pref/session_pref.dart';

abstract interface class SettingsRepository {
  Future<CallResult<AnnouncementsEntity>> getAnnouncements();

  Future<CallResult<TechniqueLibraryEntity>> getTechniqueLibraries();

  Future<CallResult<TemplateListEntity>> getTemplatesList();

  Future<CallResult<TemplateImplantInstrumentEntity>> getDefaultImplantsInstruments();

  Future<CallResult<ImplantInstrumentEditTemplateEntity>> getImplantsInstrumentsforTemplate(
      String templateId);

  Future<CallResult<TemplateImplantInstrumentFiltercategory>> getImplantsInstrumentsforCategory(
    String parentId,
    String childId,
  );

  Future<CallResult<TemplateKitsDetailEntiry>> getKitsDetails(String kitid);

  Future<CallResult<BaseEntity>> createEditTemplate(
    String? templateId,
    String templateName,
    List<String> implants,
    List<String> instruments,
  );
}

base class SettingsRepositoryImp extends SettingsRepository {
  final SessionPref sessionPref;
  final SettingsService settingService;

  SettingsRepositoryImp({
    required this.settingService,
    required this.sessionPref,
  });

  @override
  Future<CallResult<AnnouncementsEntity>> getAnnouncements() {
    return settingService.getAnnouncements();
  }

  @override
  Future<CallResult<TechniqueLibraryEntity>> getTechniqueLibraries() {
    return settingService.getTechniqueLibraries();
  }

  @override
  Future<CallResult<TemplateListEntity>> getTemplatesList() {
    return settingService.getTemplatesList();
  }

  @override
  Future<CallResult<TemplateImplantInstrumentEntity>> getDefaultImplantsInstruments() {
    return settingService.getDefaultImplantsInstruments();
  }

  @override
  Future<CallResult<TemplateImplantInstrumentFiltercategory>> getImplantsInstrumentsforCategory(
    String parentId,
    String childId,
  ) {
    return settingService.getImplantsInstrumentsforCategory(
      parentId,
      childId,
    );
  }

  @override
  Future<CallResult<TemplateKitsDetailEntiry>> getKitsDetails(
    String kitid,
  ) {
    return settingService.getKitsDetails(
      kitid,
    );
  }

  @override
  Future<CallResult<BaseEntity>> createEditTemplate(
    String? templateId,
    String templateName,
    List<String> implants,
    List<String> instruments,
  ) {
    return settingService.createEditTemplate(
      templateId,
      templateName,
      implants,
      instruments,
    );
  }

  @override
  Future<CallResult<ImplantInstrumentEditTemplateEntity>> getImplantsInstrumentsforTemplate(
    String templateId,
  ) {
    return settingService.getImplantsInstrumentsforTemplate(
      templateId,
    );
  }
}
