sealed class BackorderReportState {}

class BackorderReportInitialState extends BackorderReportState {}

class BackorderReportLoadingState extends BackorderReportState {}

class BackorderReportResultState extends BackorderReportState {}

class BackorderReportErrorState extends BackorderReportState {
  final String error;
  final bool isAuthError;

  BackorderReportErrorState({
    required this.error,
    required this.isAuthError,
  });
}
