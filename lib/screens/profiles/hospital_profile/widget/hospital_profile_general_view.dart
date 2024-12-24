import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'hospital_profile_general_card_view.dart';

class HospitalProfileGeneralView extends StatelessWidget {
  const HospitalProfileGeneralView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.hospitalProfilesScreen_general_tab_contacts,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    )),
            const SizedBox(
              height: 4,
            ),
            Expanded(
                child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return const HospitalProfileGeneralCardView();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
