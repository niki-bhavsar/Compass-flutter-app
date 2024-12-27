import 'package:compass_software/screens/profiles/surgeon_profile/surgeon_profile_bloc.dart';
import 'package:compass_software/screens/profiles/surgeon_profile/widget/surgeon_profile_events_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class SurgeonProfileEventsView extends StatelessWidget {
  const SurgeonProfileEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SurgeonProfileBloc>();
    var eventTitles = bloc.events.keys.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        itemCount: bloc.events.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final eventTitle = eventTitles[index];
          final eventData = bloc.events[eventTitle] ?? [];
          return StickyHeader(
            header: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Theme.of(context).colorScheme.primary,
              ),
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                eventTitle,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
            content: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: eventData.length,
              itemBuilder: (BuildContext context, int index) {
                return SurgeonProfileEventsCardView(
                  surgeonEvent: eventData[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
