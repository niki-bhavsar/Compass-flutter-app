import 'package:compass_software/data/entity/hospital_notes_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HospitalNotesCardView extends StatelessWidget {
  final HospitalNotesData notesData;
  const HospitalNotesCardView({
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
