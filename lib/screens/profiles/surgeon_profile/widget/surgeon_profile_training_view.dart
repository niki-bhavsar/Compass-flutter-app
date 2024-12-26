import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../surgeon_profile_bloc.dart';

class SurgeonProfileTrainingView extends StatelessWidget {
  const SurgeonProfileTrainingView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SurgeonProfileBloc>();
    var trainingTitle = bloc.trainingList.keys.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.surgeonProfilesScreen_training_tab,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(
            height: 4,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              itemCount: trainingTitle.length,
              itemBuilder: (BuildContext context, int index) {
                final title = trainingTitle[index];
                return _SurgeonProfileTrainingCardView(
                  title: title,
                  subTitle: bloc.trainingList[title] ?? "",
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SurgeonProfileTrainingCardView extends StatelessWidget {
  final String title;
  final String subTitle;

  const _SurgeonProfileTrainingCardView({required this.title, required this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          subTitle == "" ? "No data available" : subTitle,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.scrim),
        ),
      ),
    );
  }
}
