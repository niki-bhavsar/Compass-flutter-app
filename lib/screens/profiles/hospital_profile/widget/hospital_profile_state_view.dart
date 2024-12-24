import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/hospital_profile/bloc/hospital_profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../bloc/hospital_profile_state.dart';
import '../hospital_profile_bloc.dart';

class HospitalProfileStateView extends StatelessWidget {
  final HospitalProfileState state;

  const HospitalProfileStateView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        body: HospitalProfileStateSubView(state: state));
  }
}

class HospitalProfileStateSubView extends StatelessWidget {
  final HospitalProfileState state;

  const HospitalProfileStateSubView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is HospitalProfileLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is HospitalProfileErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          final bloc = context.read<HospitalProfileBloc>();
          bloc.add(HospitalsProfileFetchEvent(bloc.hospitalDetail?.id ?? ""));
        },
      );
    }

    return StateView(
      title: context.l10n.profilesScreen_title,
      message: context.l10n.hospitalProfilesScreen_no_data_message,
    );
  }
}
