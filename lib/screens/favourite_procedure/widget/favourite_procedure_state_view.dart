import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../bloc/favourite_procedure_event.dart';
import '../bloc/favourite_procedure_state.dart';
import '../favourite_procedure_bloc.dart';

class FavouriteProcedureStateView extends StatelessWidget {
  final FavouriteProcedureState state;

  const FavouriteProcedureStateView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is FavouriteProcedureLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is FavouriteProcedureErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          context.read<FavouriteProcedureBloc>().add(FavouriteProcedureFetchEvent());
        },
      );
    }

    return StateView(
      title: context.l10n.favouriteProcedureScreen_title,
      message: context.l10n.no_data_message,
      action: context.l10n.action_try_again,
      onAction: () {
        context.read<FavouriteProcedureBloc>().add(FavouriteProcedureFetchEvent());
      },
    );
  }
}
