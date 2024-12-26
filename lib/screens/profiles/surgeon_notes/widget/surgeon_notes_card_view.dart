import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../data/entity/surgeon_notes_entity.dart';

class SurgeonNotesCardView extends StatelessWidget {
  final SurgeonNotesData notesData;
  const SurgeonNotesCardView({
    super.key,
    required this.notesData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: Theme.of(context).colorScheme.onPrimary,
          child: ExpansionTile(
            title: Text(
              notesData.title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(
                height: 8,
              ),
              Html(
                data: notesData.notes,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
