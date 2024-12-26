import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../bloc/surgeon_profile_event.dart';
import '../bloc/surgeon_profile_state.dart';
import '../surgeon_profile_bloc.dart';

class SurgeonProfileStateView extends StatelessWidget {
  final SurgeonProfileState state;

  const SurgeonProfileStateView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        body: SurgeonProfileStateSubView(state: state));
  }
}

class SurgeonProfileStateSubView extends StatelessWidget {
  final SurgeonProfileState state;

  const SurgeonProfileStateSubView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is SurgeonProfileLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is SurgeonProfileErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          final bloc = context.read<SurgeonProfileBloc>();
          bloc.add(SurgeonProfileFetchEvent(bloc.surgeonDetail?.id ?? ""));
        },
      );
    }

    return StateView(
      title: context.l10n.profilesScreen_title,
      message: context.l10n.surgeonProfilesScreen_no_data_message,
    );
  }
}
