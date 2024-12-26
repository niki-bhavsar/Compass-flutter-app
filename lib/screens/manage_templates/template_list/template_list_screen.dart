import 'package:compass_software/data/entity/templates_list_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/login/login_screen.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/create_edit_template_screen.dart';
import 'package:compass_software/screens/manage_templates/template_list/state/templates_list_state.dart';
import 'package:compass_software/screens/manage_templates/template_list/templates_list_cubit.dart';
import 'package:compass_software/screens/manage_templates/template_list/widget/template_card.dart';
import 'package:compass_software/screens/manage_templates/template_list/widget/template_list_state_view.dart';
import 'package:compass_software/widget/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemplateListScreen extends StatelessWidget {
  const TemplateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TemplatesListCubit(
              settingsRepository: context.read(),
            ),
        child: const TemplateListPage());
  }
}

class TemplateListPage extends StatelessWidget {
  const TemplateListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.templateListScreen_title),
        centerTitle: false,
        actions: [
          AppIconButton(
            onPressed: () async {
              // _showFilter(context);
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateEditTemplateScreen(),
                ),
              );
              if (context.mounted) {
                context.read<TemplatesListCubit>().fetchTemplatesListData();
              }
              // context.navigate(const CreateEditTemplateScreen());
            },
            icon: Icons.add,
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: BlocConsumer<TemplatesListCubit, TemplatesListState>(
        listener: (context, state) {
          if (state is TemplateListErrorState && state.isAuthError) {
            context.navigateAndReplace(const LoginScreen());
          }
        },
        builder: (context, state) {
          if (state is TemplateListSuccessState) {
            return Flex(
              direction: Axis.vertical,
              children: [
                const SizedBox(
                  height: 8.0,
                ),
                Flexible(child: TemplateList(templateList: state.templateListEntity ?? []))
              ],
            );
          }
          return TemplateListStateView(state: state);
        },
      ),
    );
  }
}

class TemplateList extends StatelessWidget {
  final List<TemplateListInfo> templateList;
  const TemplateList({super.key, required this.templateList});

  @override
  Widget build(BuildContext context) {
    if (templateList.isEmpty) {
      return Center(
        child: Text(
          context.l10n.createEditTemplate_implant_noData_message,
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: templateList.length,
      itemBuilder: (BuildContext context, int index) {
        return TemplateCard(templateDetail: templateList[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
