sealed class HospitalNotesState {}

class HospitalNotesInitialState extends HospitalNotesState {}

class HospitalNotesLoadingState extends HospitalNotesState {}

class HospitalNotesResultState extends HospitalNotesState {}

class HospitalNotesErrorState extends HospitalNotesState {
  final String error;
  final bool isAuthError;

  HospitalNotesErrorState({
    required this.error,
    required this.isAuthError,
  });
}
