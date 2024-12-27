import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../surgeon_profile_bloc.dart';

class SurgeonProfileTrainingView extends StatelessWidget {
  const SurgeonProfileTrainingView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SurgeonProfileBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SurgeonProfileTrainingCardView(
              title: bloc.surgeonDetail?.training?.unGradName ?? "",
              subTitle: context.l10n.surgeonProfilesScreen_training_underGraduate.toUpperCase(),
              startYear: bloc.surgeonDetail?.training?.unGradStartYear ?? "",
              endYear: bloc.surgeonDetail?.training?.unGradEndYear ?? "",
            ),
            const SizedBox(
              height: 8,
            ),
            _SurgeonProfileTrainingCardView(
              title: bloc.surgeonDetail?.training?.medSchName ?? "",
              subTitle: context.l10n.surgeonProfilesScreen_training_medical_school.toUpperCase(),
              startYear: bloc.surgeonDetail?.training?.medSchStartYear ?? "",
              endYear: bloc.surgeonDetail?.training?.medSchEndYear ?? "",
            ),
            const SizedBox(
              height: 8,
            ),
            _SurgeonProfileTrainingCardView(
              title: bloc.surgeonDetail?.training?.residencyName ?? "",
              subTitle: context.l10n.surgeonProfilesScreen_training_residency.toUpperCase(),
              startYear: bloc.surgeonDetail?.training?.residencyStartYear ?? "",
              endYear: bloc.surgeonDetail?.training?.residencyEndYear ?? "",
            ),
            const SizedBox(
              height: 8,
            ),
            _SurgeonProfileTrainingCardView(
              title: bloc.surgeonDetail?.training?.fellowshipName ?? "",
              subTitle: context.l10n.surgeonProfilesScreen_training_fellowship.toUpperCase(),
              startYear: bloc.surgeonDetail?.training?.fellowshipStartYear ?? "",
              endYear: bloc.surgeonDetail?.training?.fellowshipEndYear ?? "",
            ),
            const SizedBox(
              height: 8,
            ),
            _SurgeonProfileTrainingCardView(
              title: bloc.surgeonDetail?.training?.trainingNotes ?? "",
              subTitle: context.l10n.surgeonProfilesScreen_training_notes.toUpperCase(),
              startYear: "",
              endYear: "",
            )
          ],
        ),
      ),
    );
  }
}

class _SurgeonProfileTrainingCardView extends StatelessWidget {
  final String title;
  final String subTitle;
  final String startYear;
  final String endYear;

  const _SurgeonProfileTrainingCardView({
    required this.title,
    required this.subTitle,
    required this.startYear,
    required this.endYear,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title.isNotEmpty ? title : "N/A",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          subTitle,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.scrim),
        ),
        trailing: Text('$startYear-$endYear'),
      ),
    );
  }
}
