import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/manage_templates/template_list/state/templates_list_state.dart';
import 'package:compass_software/screens/manage_templates/template_list/templates_list_cubit.dart';
import 'package:compass_software/widget/progress.dart';
import 'package:compass_software/widget/state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemplateListStateView extends StatelessWidget {
  final TemplatesListState state;
  const TemplateListStateView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is TemplateListLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is TemplateListErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.tryAgain_button_title,
        onAction: () {
          context.read<TemplatesListCubit>().fetchTemplatesListData();
        },
      );
    }

    return StateView(
      title: context.l10n.announcementScreen_title,
      message: context.l10n.announcementScreen_noData_message,
      action: context.l10n.tryAgain_button_title,
      onAction: () {
        context.read<TemplatesListCubit>().fetchTemplatesListData();
      },
    );
  }
}
