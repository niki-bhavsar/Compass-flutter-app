import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../data/shared_pref/session_pref.dart';

class PreferenceAutoCaptureCard extends StatefulWidget {
  const PreferenceAutoCaptureCard({
    super.key,
  });

  @override
  State<PreferenceAutoCaptureCard> createState() => _PreferenceAutoCaptureCardState();
}

class _PreferenceAutoCaptureCardState extends State<PreferenceAutoCaptureCard> {
  bool isAutoCapture = GetIt.instance.get<SessionPref>().getAutoCaptureEnabled();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: ListTile(
        title: Row(
          children: [
            Text(
              context.l10n.my_preferenceScreen_auto_capture_title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Switch(
              activeColor: Theme.of(context).colorScheme.scrim,
              thumbColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
              value: isAutoCapture,
              onChanged: (bool value) {
                setState(() {
                  isAutoCapture = value;
                  GetIt.instance.get<SessionPref>().setAutoCaptureEnabled(isAutoCapture);
                });
              },
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            context.l10n.my_preferenceScreen_auto_capture_info,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Theme.of(context).colorScheme.scrim, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
