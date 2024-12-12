import 'package:compass_software/data/entity/announcement_entity.dart';
import 'package:compass_software/data/entity/technique_library_entity.dart';
import 'package:compass_software/data/service/model/call_result.dart';
import 'package:compass_software/data/service/settings_service.dart';
import 'package:compass_software/data/shared_pref/session_pref.dart';

abstract interface class SettingsReposotory {
  Future<CallResult<AnnouncementsEntity>> getAnnouncements();

  Future<CallResult<TechniqueLibraryEntity>> getTechniqueLibraries();
}

base class SettingsReposotoryImp extends SettingsReposotory {
  final SessionPref sessionPref;
  final SettingsService settingService;

  SettingsReposotoryImp({required this.settingService, required this.sessionPref});

  @override
  Future<CallResult<AnnouncementsEntity>> getAnnouncements() {
    return settingService.getAnnouncements();
  }

  @override
  Future<CallResult<TechniqueLibraryEntity>> getTechniqueLibraries() {
    return settingService.getTechniqueLibraries();
  }
}
