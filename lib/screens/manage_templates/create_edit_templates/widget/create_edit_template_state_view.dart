import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../state/create_edit_template_state.dart';

class CreateEditTemplateStateView extends StatelessWidget {
  final CreateEditTemplateState state;

  const CreateEditTemplateStateView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is CreateEditTemplateLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is CreateEditTemplateErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          // context.read<MyProfileBloc>().add(UserProfileFetchEvent());
        },
      );
    }

    return StateView(
      title: "No data found",
      message: context.l10n.createEditTemplate_implant_noData_message,
    );
  }
}
