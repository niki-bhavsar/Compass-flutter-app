import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/categories/widget/template_categories_card.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/create_edit_template_cubit.dart';
import 'package:compass_software/widget/app_icon_button.dart';
import 'package:flutter/material.dart';

class TemplateCategoriesScreen extends StatelessWidget {
  final CreateEditTemplateCubit cubic;

  const TemplateCategoriesScreen({super.key, required this.cubic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          width: 64,
          height: 4,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondaryFixedVariant, //Colors.grey,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Text(
                context.l10n.template_filter_categories_title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              AppIconButton(
                icon: Icons.close_sharp,
                onPressed: () => {
                  Navigator.pop(context),
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: TemplateCategoriesList(cubic: cubic),
        ),
      ],
    );
  }
}

class TemplateCategoriesList extends StatelessWidget {
  final CreateEditTemplateCubit cubic;

  const TemplateCategoriesList({
    super.key,
    required this.cubic,
  });

  @override
  Widget build(BuildContext context) {
    final filterList = cubic.filterList;
    if (filterList.isEmpty) {
      return Center(
        child: Text(
          context.l10n.createEditTemplate_implant_noData_message,
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filterList.length,
      itemBuilder: (BuildContext context, int index) {
        return TemplateCategoriesCard(
          filter: filterList[index],
          cubic: cubic,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
