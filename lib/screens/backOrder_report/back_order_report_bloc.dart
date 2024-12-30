import 'package:compass_software/data/entity/back_order_report_product_entity.dart';
import 'package:compass_software/data/repository/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/service/model/call_result.dart';
import '../../data/entity/back_order_report_location_entity.dart';
import 'back_order_report_screen.dart';
import 'bloc/back_order_report_event.dart';
import 'bloc/back_order_report_state.dart';

class BackorderReportBloc extends Bloc<BackorderReportEvent, BackorderReportState> {
  final SettingsRepository settingsRepository;

  ReportType viewBy = ReportType.product;
  ReportView viewRecord = ReportView.all;

  List<Location> backOrderLocations = [];
  List<Product> backOrderProducts = [];

  BackorderReportBloc({
    required this.settingsRepository,
  }) : super(BackorderReportInitialState()) {
    on<BackorderReportFetchEvent>(_handleBackorderReportFetchEvent);
  }

  _handleBackorderReportFetchEvent(
    BackorderReportFetchEvent event,
    Emitter<BackorderReportState> emit,
  ) async {
    if (event.type != null) viewBy = event.type!;
    if (event.view != null) viewRecord = event.view!;

    emit(BackorderReportLoadingState());

    if (viewBy == ReportType.product) {
      final result = await settingsRepository.getBackOrderListByProduct(
        viewRecord: viewRecord.name,
      );
      if (result is Failure<BackorderReportProductEntity>) {
        emit(BackorderReportErrorState(
          error: result.cause,
          isAuthError: result.isAuthError(),
        ));
      } else if (result is Success<BackorderReportProductEntity>) {
        backOrderProducts.clear();
        backOrderProducts.addAll(result.data.products);
        emit(BackorderReportResultState());
      }
    } else {
      final result = await settingsRepository.getBackOrderListByLocation(
        viewRecord: viewRecord.name,
      );
      if (result is Failure<BackorderReportLocationEntity>) {
        emit(BackorderReportErrorState(
          error: result.cause,
          isAuthError: result.isAuthError(),
        ));
      } else if (result is Success<BackorderReportLocationEntity>) {
        backOrderLocations.clear();
        backOrderLocations.addAll(result.data.locations);
        emit(BackorderReportResultState());
      }
    }
  }
}
