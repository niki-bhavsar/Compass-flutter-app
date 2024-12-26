import 'package:compass_software/data/entity/announcement_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/annnouncement/announcementdetail/announcement_detail_screen.dart';
import 'package:compass_software/utils/intl_utils.dart';
import 'package:flutter/material.dart';

class Announcecard extends StatelessWidget {
  final AnnouncementInfo announcement;

  const Announcecard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 3),
        // to expand
        title: Text(
          announcement.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        leading: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.surface,
              width: 1,
            ),
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 1,
            vertical: 8,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                IntlUtil.getDate(announcement.createDate) ?? "", //"01-30"
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                IntlUtil.getMonth(announcement.createDate) ?? "", //"Jan"
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
              )
            ],
          ),
        ),
        trailing: const Icon(
          Icons.navigate_next_rounded,
        ),
        onTap: () {
          context.navigate(
            AnnouncementDetailScreen(
              announcementDetail: announcement,
            ),
          );
        },
      ),
    );
  }
}
