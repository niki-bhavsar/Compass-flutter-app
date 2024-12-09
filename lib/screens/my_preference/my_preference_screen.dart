import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/my_preference/widget/preference_auto_capture_card.dart';
import 'package:compass_software/screens/my_preference/widget/preference_distributor_card.dart';
import 'package:flutter/material.dart';

class MyPreferenceScreen extends StatelessWidget {
  const MyPreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(context.l10n.settingsScreen_account_my_preference),
        centerTitle: false,
      ),
      body: const MyPreferenceView(),
    );
  }
}

class MyPreferenceView extends StatelessWidget {
  const MyPreferenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PreferenceAutoCaptureCard(),
          SizedBox(height: 8),
          PreferenceDistributorCard(),
        ],
      ),
    );
  }
}
