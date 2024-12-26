import 'package:compass_software/data/entity/template_implants_intrument_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/categories/template_categories_screen.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/create_edit_template_cubit.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/state/create_edit_template_state.dart';
import 'package:compass_software/widget/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEditTemplateFormview extends StatefulWidget {
  const CreateEditTemplateFormview({super.key});

  @override
  State<CreateEditTemplateFormview> createState() => CreateEditTemplateFormviewState();
}

class CreateEditTemplateFormviewState extends State<CreateEditTemplateFormview> {
  late final ValueChanged<TemplatesFilterList> templateList;

  @override
  Widget build(BuildContext context) {
    final createEditTemplateCubit = context.read<CreateEditTemplateCubit>();
    return Form(
      key: createEditTemplateCubit.formKey,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.surface, width: 1),
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: context.l10n.createEditTemplate_nameInput_hint,
                filled: false,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              controller: createEditTemplateCubit.templateName,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: createEditTemplateCubit.autoValidateMode,
              validator: emptyTemplateNameValidate,
              autofillHints: const [AutofillHints.email],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(context.l10n.template_category_dropdown_title),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(
                                      "${context.l10n.template_category_dropdown_Selected_title}  (${createEditTemplateCubit.getSelectedItemsLength()})"),
                                  onTap: () {
                                    Navigator.pop(context); // Close the dialog
                                    createEditTemplateCubit.selectedCategoryName =
                                        context.l10n.template_category_dropdown_Selected_title;
                                    createEditTemplateCubit.setDefaultSelectedData();
                                  },
                                ),
                                ListTile(
                                  title: Text(context.l10n.template_category_dropdown_All_title),
                                  onTap: () {
                                    Navigator.pop(context);
                                    createEditTemplateCubit.selectedCategoryName =
                                        context.l10n.template_category_dropdown_All_title;
                                    createEditTemplateCubit.setDefaultAllData();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.surface, width: 1),
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(2.0),
                      margin: const EdgeInsets.only(right: 10),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<CreateEditTemplateCubit, CreateEditTemplateState>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(createEditTemplateCubit.selectedCategoryName),
                                  ),
                                  const Icon(Icons.arrow_drop_down)
                                ],
                              );
                            },
                          )),
                    ),
                  ),
                ),
                AppIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // Allow the sheet to be sized
                      builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.8, // Set the height to 80% of the screen height
                        child: TemplateCategoriesScreen(cubic: createEditTemplateCubit),
                      ),
                    );
                  },
                  icon: Icons.filter_list,
                ),
              ],
            ),
            BlocBuilder<CreateEditTemplateCubit, CreateEditTemplateState>(
              builder: (context, state) {
                if (state is CreateEditTemplateErrorState) {
                  return Column(
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        state.error,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.error),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  String? emptyTemplateNameValidate(String? text) {
    if (text == null || text.trim().isEmpty) {
      return context.l10n.createEditTemplate_nameInput_emptyError;
    }
    return null;
  }
}
