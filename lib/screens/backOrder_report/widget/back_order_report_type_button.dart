import 'package:flutter/material.dart';

class BackOrderSegmentButton<T> extends StatelessWidget {
  final T selectedType;
  final T type1;
  final String type1Text;
  final T type2;
  final String type2Text;
  final void Function(Set<T>)? onSelectionChanged;

  const BackOrderSegmentButton({
    super.key,
    required this.type1,
    required this.type2,
    required this.type1Text,
    required this.type2Text,
    required this.selectedType,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      child: SegmentedButton<T>(
        selectedIcon: null,
        segments: <ButtonSegment<T>>[
          ButtonSegment(
            value: type1,
            label: Text(type1Text),
          ),
          ButtonSegment(
            value: type2,
            label: Text(type2Text),
          ),
        ],
        selected: <T>{selectedType},
        onSelectionChanged: onSelectionChanged,
      ),
    );
  }
}
