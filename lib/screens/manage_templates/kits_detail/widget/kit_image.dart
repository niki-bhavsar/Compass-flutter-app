import 'package:compass_software/data/entity/template_kits_detail_entiry.dart';
import 'package:compass_software/utils/image_view.dart';
import 'package:flutter/material.dart';

class KitImage extends StatelessWidget {
  final KitsDetail? kitDetails;

  const KitImage({super.key, required this.kitDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Kit Images",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryFixed, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.surface, width: 1),
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: const ImageView(
            imageUrl: "", //kitDetails?.kitImages?.first?.image.toString(),
            placeholder: Placeholder(),
          ),
        ),
      ],
    );
  }
}
