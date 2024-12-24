import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../bloc/profiles_event.dart';
import '../bloc/profiles_state.dart';
import '../profiles_bloc.dart';

class ProfilesStateView extends StatelessWidget {
  final ProfilesState state;
  final bool isHospitalData;

  const ProfilesStateView({
    super.key,
    required this.state,
    required this.isHospitalData,
  });

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is ProfilesLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is ProfilesErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          context.read<ProfilesBloc>().add(HospitalsListFetchEvent());
        },
      );
    }

    return StateView(
      title: context.l10n.profilesScreen_title,
      message: isHospitalData == true
          ? context.l10n.profilesScreen_hospitals_no_data_message
          : context.l10n.profilesScreen_surgeons_no_data_message,
    );
  }
}
