import 'package:compass_software/data/entity/announcement_entity.dart';

sealed class AnnouncementsState {}

class AnnouncementInitialState extends AnnouncementsState {}

class AnnouncementLoadingState extends AnnouncementsState {}

class AnnouncementSuccessState extends AnnouncementsState {
  final Map<String, List<AnnouncementInfo>> announcemets;

  AnnouncementSuccessState({required this.announcemets});
}

class AnnouncementsErrorState extends AnnouncementsState {
  final String error;
  final int code;
  AnnouncementsErrorState({
    required this.error,
    required this.code,
  });
}
