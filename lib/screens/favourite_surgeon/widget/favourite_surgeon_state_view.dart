import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../bloc/favourite_surgeon_event.dart';
import '../bloc/favourite_surgeon_state.dart';
import '../favourite_surgeon_bloc.dart';

class FavouriteSurgeonStatView extends StatelessWidget {
  final FavouriteSurgeonState state;

  const FavouriteSurgeonStatView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is FavouriteSurgeonLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is FavouriteSurgeonErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          context.read<FavouriteSurgeonBloc>().add(FavouriteSurgeonFetchEvent());
        },
      );
    }

    return StateView(
      title: context.l10n.favouriteSurgeonScreen_title,
      message: context.l10n.no_data_message,
      action: context.l10n.action_try_again,
      onAction: () {
        context.read<FavouriteSurgeonBloc>().add(FavouriteSurgeonFetchEvent());
      },
    );
  }
}
