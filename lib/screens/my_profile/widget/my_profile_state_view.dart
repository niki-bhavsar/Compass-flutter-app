import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../bloc/my_profile_event.dart';
import '../bloc/my_profile_state.dart';
import '../my_profile_bloc.dart';

class MyProfileStateView extends StatelessWidget {
  final MyProfileState state;

  const MyProfileStateView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is MyProfileLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is MyProfileErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          context.read<MyProfileBloc>().add(UserProfileFetchEvent());
        },
      );
    }

    return StateView(
      title: context.l10n.settingsScreen_account_my_profile,
      message: context.l10n.no_data_message,
      action: context.l10n.action_try_again,
      onAction: () {
        context.read<MyProfileBloc>().add(UserProfileFetchEvent());
      },
    );
  }
}
