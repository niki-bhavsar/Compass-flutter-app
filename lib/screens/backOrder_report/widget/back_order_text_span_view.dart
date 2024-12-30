import 'package:flutter/material.dart';

class BackOrderTextSpanView extends StatelessWidget {
  final String? title;
  final String? value;
  const BackOrderTextSpanView({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.outline),
        children: <InlineSpan>[
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface),
          )
        ],
      ),
    );
  }
}
