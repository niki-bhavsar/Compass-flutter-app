import 'package:compass_software/data/entity/technique_library_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class TechniqueCard extends StatelessWidget {
  final TechniqueLibraryInfo techniqueLibrary;

  const TechniqueCard({super.key, required this.techniqueLibrary});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          techniqueLibrary.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                flex: 2, // Allocate 2 parts of the total space
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.surface, width: 1),
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                      children: [
                        Text(
                          context.l10n.techniqueLibraryScreen_anatomy_title, // First text
                        ),
                        Text(
                          techniqueLibrary.anatomy,
                          maxLines: 1, //
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15), // Add some spacing between containers
              Expanded(
                flex: 2, // Allocate 2 parts of the total space
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.surface, width: 1),
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                      children: [
                        Text(
                          context.l10n.techniqueLibraryScreen_system_title, // First text
                        ),
                        Text(
                          techniqueLibrary.system,
                          maxLines: 1, //
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          // context.navigate (AppRoute.profile, contact.id.toString());
        },
      ),
    );
  }
}
