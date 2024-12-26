import 'package:compass_software/data/entity/template_implants_intrument_entity.dart';
import 'package:compass_software/data/entity/templates_list_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/login/login_screen.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/create_edit_template_cubit.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/state/create_edit_template_state.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/widget/create_edit_template_formview.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/widget/implant_instrument_card.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/widget/implant_instrument_segment.dart';
import 'package:compass_software/widget/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/create_edit_template_state_view.dart';

class CreateEditTemplateScreen extends StatelessWidget {
  final TemplateListInfo? templateDetails;

  const CreateEditTemplateScreen({super.key, this.templateDetails});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateEditTemplateCubit(
        settingsRepository: context.read(),
        templateDetails: templateDetails,
      )..fetchImplantInstrumentData(),
      child: const _CreateEditTemplateScaffold(),
    );
  }
}

class _CreateEditTemplateScaffold extends StatelessWidget {
  const _CreateEditTemplateScaffold();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEditTemplateCubit>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: cubit.isEditMode
            ? Text(context.l10n.editTemplate_title)
            : Text(context.l10n.createNewTemplate_title),
        actions: [
          AppIconButton(
            onPressed: () {
              cubit.handleSaveTemplateEvent();
            },
            icon: Icons.check,
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: BlocConsumer<CreateEditTemplateCubit, CreateEditTemplateState>(
        listener: (context, state) {
          if (state is CreateEditTemplateErrorState && state.isAuthError) {
            context.navigateAndReplace(const LoginScreen());
          }
          if (state is CreateEditTemplateNewCreatedState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final implants = cubit.implantInstrumentEntity?.implants ?? [];
          final instruments = cubit.implantInstrumentEntity?.instruments ?? [];
          if (state is CreateEditTemplateFetchImplantInstrumentSuccessState ||
              implants.isNotEmpty ||
              instruments.isNotEmpty) {
            return Column(
              children: [
                const CreateEditTemplateFormview(),
                Expanded(
                  child: Card(
                    color: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ImplantInstrumentSegment(
                          selectedIndex: cubit.selectedMenu,
                          onSegmentChanged: (int index) {
                            cubit.setSelectedMenu(index);
                          },
                        ),
                        Expanded(
                          child: ImplantInstrumentList(
                            implantList: cubit.selectedMenu == 0 ? implants : instruments,
                            isImplant: cubit.selectedMenu == 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return CreateEditTemplateStateView(state: state);
        },
      ),
    );
  }
}

class ImplantInstrumentList extends StatelessWidget {
  final List<ImplantEntity> implantList;
  final bool isImplant;

  const ImplantInstrumentList({
    super.key,
    required this.implantList,
    this.isImplant = true,
  });

  @override
  Widget build(BuildContext context) {
    if (implantList.isEmpty) {
      return Center(
        child: Text(
          context.l10n.createEditTemplate_implant_noData_message,
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: implantList.length,
      itemBuilder: (BuildContext context, int index) {
        return ImplantInstrumentCard(
          implant: implantList[index],
          isImplant: isImplant,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
