import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/backOrder_report/bloc/back_order_report_state.dart';
import 'package:compass_software/screens/backOrder_report/widget/back_order_report_location_list.dart';
import 'package:compass_software/screens/backOrder_report/widget/back_order_report_product_list.dart';
import 'package:compass_software/screens/backOrder_report/widget/back_order_report_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/settings_repository.dart';
import '../login/login_screen.dart';
import 'back_order_report_bloc.dart';
import 'bloc/back_order_report_event.dart';
import 'widget/back_order_report_type_button.dart';

class BackorderReportScreen extends StatelessWidget {
  const BackorderReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BackorderReportBloc(
        settingsRepository: context.read<SettingsRepository>(),
      )..add(
          BackorderReportFetchEvent(),
        ),
      child: _BackOrderReportScaffold(),
    );
  }
}

class _BackOrderReportScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.backOrderReportScreen_title),
        centerTitle: false,
      ),
      body: _BackOrderReportView(),
    );
  }
}

enum ReportType { product, location }

enum ReportView { all, today }

class _BackOrderReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<BackorderReportBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<BackorderReportBloc, BackorderReportState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      context.l10n.backOrderReportScreen_view_by,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 4),
                  BackOrderSegmentButton(
                    selectedType: bloc.viewBy,
                    type1: ReportType.product,
                    type1Text: context.l10n.backOrderReportScreen_product,
                    type2: ReportType.location,
                    type2Text: context.l10n.backOrderReportScreen_location,
                    onSelectionChanged: (Set<ReportType> newSelected) {
                      bloc.add(BackorderReportFetchEvent(type: newSelected.first));
                    },
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      context.l10n.backOrderReportScreen_filter_by,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 4),
                  BackOrderSegmentButton(
                    selectedType: bloc.viewRecord,
                    type1: ReportView.all,
                    type1Text: context.l10n.backOrderReportScreen_view_all,
                    type2: ReportView.today,
                    type2Text: context.l10n.backOrderReportScreen_today,
                    onSelectionChanged: (Set<ReportView> newSelected) {
                      bloc.add(BackorderReportFetchEvent(view: newSelected.first));
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: BlocConsumer<BackorderReportBloc, BackorderReportState>(
              listener: (context, state) {
                if (state is BackorderReportErrorState && state.isAuthError == true) {
                  context.navigateAndReplace(const LoginScreen());
                }
              },
              builder: (context, state) {
                if (state is BackorderReportResultState) {
                  return bloc.viewBy == ReportType.product
                      ? const BackOrderReportProductList()
                      : const BackOrderReportLocationList();
                } else {
                  return BackorderReportStateView(
                    state: state,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
