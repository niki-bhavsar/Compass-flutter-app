import 'package:compass_software/data/entity/announcement_entity.dart';
import 'package:compass_software/data/repository/settings_reposotory.dart';
import 'package:compass_software/data/service/model/call_result.dart';
import 'package:compass_software/screens/announcements/state/announcements_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  final SettingsReposotory settingsReposotory;
  AnnouncementsCubit({required this.settingsReposotory}) : super(AnnouncementInitialState()) {
    fetchAnnouncementData();
  }

  void fetchAnnouncementData() async {
    emit(AnnouncementLoadingState());
    CallResult<AnnouncementsEntity> response = await settingsReposotory.getAnnouncements();

    if (response is Failure<AnnouncementsEntity>) {
      emit(AnnouncementsErrorState(
        error: response.cause,
        code: response.code,
      ));
    } else if (response is Success<AnnouncementsEntity>) {
      emit(AnnouncementSuccessState(announcemets: groupAnnouncementsByYear(response.data.values)));
    }
  }

  Map<String, List<AnnouncementInfo>> groupAnnouncementsByYear(
      List<AnnouncementInfo> announcements) {
    Map<String, List<AnnouncementInfo>> grouped = {};

    for (var announcement in announcements) {
      // Extract year from createDate
      String year = announcement.createDate?.year.toString() ?? ""; // Get the year from the date
      if (!grouped.containsKey(year)) {
        grouped[year] = [];
      }
      grouped[year]!.add(announcement);
    }

    return grouped;
  }
}
