import 'package:compass_software/data/entity/announcement_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/annnouncement/announcements/announcements_cubit.dart';
import 'package:compass_software/screens/annnouncement/announcements/state/announcements_state.dart';
import 'package:compass_software/screens/annnouncement/announcements/widget/announce_card.dart';
import 'package:compass_software/screens/annnouncement/announcements/widget/announce_stateview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnnouncementsCubit(
        settingsRepository: context.read(),
      ),
      child: const AnnouncementsPage(),
    );
  }
}

class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(context.l10n.announcementScreen_title),
        centerTitle: true,
      ),
      body: BlocConsumer<AnnouncementsCubit, AnnouncementsState>(
        listener: (context, state) {
          if (state is AnnouncementsErrorState) {
            // context.navigateAndReplace(AppRoute.login);
          }
        },
        builder: (context, state) {
          if (state is AnnouncementSuccessState && state.announcemets.isNotEmpty) {
            return _AnnouncementList(
              announcements: state.announcemets,
            );
          } else {
            return Announcestateview(
              state: state,
            );
          }
        },
      ),
    );
  }
}

class _AnnouncementList extends StatelessWidget {
  final Map<String, List<AnnouncementInfo>> announcements;

  const _AnnouncementList({required this.announcements});

  @override
  Widget build(BuildContext context) {
    var keys = announcements.keys.toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
            child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          itemCount: announcements.keys.length,
          itemBuilder: (BuildContext context, int index) {
            String year = keys[index];
            List<AnnouncementInfo> yearAnnouncements = announcements[keys[index]] ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display year header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Text(
                    year, // Display the year (e.g., "2024")
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                // Display announcements for this year
                ...yearAnnouncements.map(
                  (announcement) {
                    return Announcecard(announcement: announcement);
                  },
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 1);
          },
        ))
      ],
    );
  }
}
