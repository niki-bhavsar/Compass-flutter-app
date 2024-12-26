import 'package:compass_software/data/entity/templates_list_entity.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/create_edit_template_screen.dart';
import 'package:compass_software/screens/manage_templates/template_list/templates_list_cubit.dart';
import 'package:compass_software/utils/intl_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemplateCard extends StatelessWidget {
  final TemplateListInfo templateDetail;

  const TemplateCard({super.key, required this.templateDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 3),
        // to expand
        title: Text(
          templateDetail.name ?? "",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          IntlUtil.getFullDate(templateDetail.dateCreated, dateFormat: "MM/dd/yyyy") ?? "",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w300, color: Theme.of(context).colorScheme.inverseSurface),
        ),
        trailing: const Icon(Icons.navigate_next_rounded),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEditTemplateScreen(templateDetails: templateDetail),
            ),
          );
          if (context.mounted) {
            context.read<TemplatesListCubit>().fetchTemplatesListData();
          }
        },
      ),
    );
  }
}
