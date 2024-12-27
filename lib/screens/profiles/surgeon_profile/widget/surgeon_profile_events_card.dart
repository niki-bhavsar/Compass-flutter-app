import 'package:flutter/material.dart';
import '../../../../data/entity/surgeon_events_entity.dart';

class SurgeonProfileEventsCardView extends StatelessWidget {
  final SurgeonEvent surgeonEvent;

  const SurgeonProfileEventsCardView({
    super.key,
    required this.surgeonEvent,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              surgeonEvent.eventName ?? "",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.event,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  surgeonEvent.eventType ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.date_range_outlined,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  surgeonEvent.eventStartDate ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.date_range_outlined,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  surgeonEvent.eventEndDate ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.location_city_outlined,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  surgeonEvent.fullAddress() ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
