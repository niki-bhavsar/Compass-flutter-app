import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../bloc/favourite_hospital_event.dart';
import '../bloc/favourite_hospital_state.dart';
import '../favourite_hospital_bloc.dart';

class FavouriteHospitalStateView extends StatelessWidget {
  final FavouriteHospitalState state;

  const FavouriteHospitalStateView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is FavouriteHospitalLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is FavouriteHospitalErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          context.read<FavouriteHospitalBloc>().add(FavouriteHospitalFetchEvent());
        },
      );
    }

    return StateView(
      title: context.l10n.favouriteHospitalScreen_title,
      message: context.l10n.no_data_message,
    );
  }
}
