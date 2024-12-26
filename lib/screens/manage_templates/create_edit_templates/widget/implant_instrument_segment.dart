import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class ImplantInstrumentSegment extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onSegmentChanged;

  const ImplantInstrumentSegment(
      {super.key, required this.selectedIndex, required this.onSegmentChanged});

  @override
  State<ImplantInstrumentSegment> createState() => ImplantInstrumentSegmentView();
}

class ImplantInstrumentSegmentView extends State<ImplantInstrumentSegment> {
  int selectedSegmentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSegment(context.l10n.createEditTemplate_Implants_segment_title, 0),
        _buildSegment(context.l10n.createEditTemplate_Instruments_segment_title, 1),
      ],
    );
  }

  Widget _buildSegment(String title, int index) {
    bool isSelected = selectedSegmentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedSegmentIndex = index;
            widget.onSegmentChanged(index);
          });
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: isSelected
                  ? BorderSide(color: Theme.of(context).colorScheme.surfaceTint, width: 3)
                  : BorderSide(
                      color: Theme.of(context).colorScheme.surfaceTint.withValues(alpha: 0.2),
                      width: 1,
                    ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.scrim,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
