import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../back_order_report_bloc.dart';
import '../back_order_report_screen.dart';
import '../bloc/back_order_report_event.dart';
import '../bloc/back_order_report_state.dart';

class BackorderReportStateView extends StatelessWidget {
  final BackorderReportState state;

  const BackorderReportStateView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<BackorderReportBloc>();
    var st = state;
    if (st is BackorderReportLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is BackorderReportErrorState) {
      return StateView(
        title: context.l10n.stateView_message,
        message: st.error,
        action: context.l10n.action_try_again,
        onAction: () {
          context.read<BackorderReportBloc>().add(BackorderReportFetchEvent());
        },
      );
    }

    return StateView(
      title: context.l10n.backOrderReportScreen_title,
      message: bloc.viewBy == ReportType.product
          ? context.l10n.backOrderReportScreen_product_no_data_message
          : context.l10n.backOrderReportScreen_location_no_data_message,
    );
  }
}
