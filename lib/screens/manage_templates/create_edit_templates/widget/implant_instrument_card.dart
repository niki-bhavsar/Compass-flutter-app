import 'package:compass_software/data/entity/template_implants_intrument_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/manage_templates/kits_detail/kits_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../create_edit_template_cubit.dart';

class ImplantInstrumentCard extends StatelessWidget {
  final ImplantEntity implant;
  final bool isImplant;

  const ImplantInstrumentCard({
    super.key,
    required this.implant,
    this.isImplant = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                implant.manufacturerName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.onPrimaryFixed),
              ),
              if (implant.isEmpty())
                Text(
                  context.l10n.createEditTemplate_empty_implant_instruments_no_data,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
            ],
          ),
        ),
        if (!implant.isEmpty())
          ...implant.values.map((implant) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    implant.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.surfaceTint,
                        ),
                  ),
                ),
                buildImplant(context, implant),
              ],
            );
          }),
        const Divider(),
      ],
    );
  }

  Widget buildImplant(BuildContext context, ImplantCategory category) {
    var list = category.list;

    var cubit = context.read<CreateEditTemplateCubit>();
    if (cubit.shouldDisplaySelected) {
      list = list
          .where(
            (a) => (isImplant
                ? cubit.selectedImplants.containsKey(a.id)
                : cubit.selectedInstruments.containsKey(a.id)),
          )
          .toList();
    }

    final widgets = list.map((e) {
      return ImplantValueItem(
        value: e,
        isSelected: cubit.isSelected(e, isImplant),
        isImplant: isImplant,
        onChanged: (isSelected) {
          cubit.updateImplantInstrument(
            e,
            isSelected ?? false,
            isImplant,
          );
        },
      );
    }).toList();

    return Column(children: widgets);
  }
}

class ImplantValueItem extends StatelessWidget {
  final ImplantValue value;
  final bool isImplant;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;

  const ImplantValueItem({
    super.key,
    required this.value,
    required this.onChanged,
    this.isImplant = true,
    this.isSelected = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            context.navigate(KitsDetailScreen(kitId: value.id ?? ""));
          },
          icon: const Icon(Icons.info),
          padding: EdgeInsets.zero,
        ),
        Expanded(
          child: ListTile(
            title: Text(value.name ?? context.l10n.template_kit_Unknown_Value),
            contentPadding: EdgeInsets.zero,
            onTap: () {
              onChanged?.call(!isSelected);
            },
            trailing: Checkbox(
              value: isSelected,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
