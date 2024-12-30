import 'package:compass_software/screens/backOrder_report/back_order_report_screen.dart';

sealed class BackorderReportEvent {}

class BackorderReportFetchEvent extends BackorderReportEvent {
  final ReportType? type;
  final ReportView? view;

  BackorderReportFetchEvent({this.type, this.view});
}
