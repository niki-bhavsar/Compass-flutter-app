import 'package:compass_software/data/entity/template_implants_intrument_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/create_edit_template_cubit.dart';
import 'package:flutter/material.dart';

class TemplateCategoriesCard extends StatelessWidget {
  final TemplatesFilterList filter;
  final CreateEditTemplateCubit cubic;

  const TemplateCategoriesCard({super.key, required this.filter, required this.cubic});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Manufacturer Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  filter.name ?? context.l10n.createEditTemplate_empty_implant_instruments_title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onPrimaryFixed),
                ),
              ],
            ),
          ),
          ...?filter.values?.map((value) {
            if (value.isHeader == 1) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Text(
                  value.title ?? context.l10n.template_kit_Unknown_Value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.surfaceTint,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            }
            return GestureDetector(
              child: FilterCategoryItem(value: value),
              onTap: () => {
                cubic.fetchImplantInstrumentDataForCategory(
                  value.title,
                  value.subHeaderId ?? filter.id.toString(),
                  value.id ?? "0",
                ),
                Navigator.pop(context),
              },
            );
          }),
          const Divider(),
        ],
      ),
    );
  }
}

class FilterCategoryItem extends StatelessWidget {
  final FilterListValue value;

  const FilterCategoryItem({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(value.title ?? context.l10n.template_kit_Unknown_Value),
    );
  }
}
