import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/technique_libraries/technique_library/state/technique_library_state.dart';
import 'package:compass_software/screens/technique_libraries/technique_library/technique_library_cubit.dart';
import 'package:compass_software/widget/progress.dart';
import 'package:compass_software/widget/state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechniqueLibraryStateView extends StatelessWidget {
  final TechniqueLibraryState state;
  const TechniqueLibraryStateView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is TechniqueLibraryLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is TechniqueLibraryErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.tryAgain_button_title,
        onAction: () {
          context.read<TechniqueLibraryCubit>().fetchTechniqueLibraryData();
        },
      );
    }

    return StateView(
        title: context.l10n.announcementScreen_title,
        message: context.l10n.announcementScreen_noData_message,
        action: context.l10n.tryAgain_button_title,
        onAction: () {
          context.read<TechniqueLibraryCubit>().fetchTechniqueLibraryData();
        });
  }
}
