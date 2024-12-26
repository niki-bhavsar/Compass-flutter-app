import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/annnouncement/announcements/announcements_cubit.dart';
import 'package:compass_software/screens/annnouncement/announcements/state/announcements_state.dart';
import 'package:compass_software/widget/progress.dart';
import 'package:compass_software/widget/state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Announcestateview extends StatelessWidget {
  final AnnouncementsState state;
  const Announcestateview({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is AnnouncementLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is AnnouncementsErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.tryAgain_button_title,
        onAction: () {
          context.read<AnnouncementsCubit>().fetchAnnouncementData();
        },
      );
    }

    return StateView(
        title: context.l10n.announcementScreen_title,
        message: context.l10n.announcementScreen_noData_message,
        action: context.l10n.tryAgain_button_title,
        onAction: () {
          context.read<AnnouncementsCubit>().fetchAnnouncementData();
        });
  }
}
