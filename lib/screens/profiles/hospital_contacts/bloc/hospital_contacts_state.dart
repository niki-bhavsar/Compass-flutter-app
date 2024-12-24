sealed class HospitalContactsState {}

class HospitalContactsInitialState extends HospitalContactsState {}

class HospitalContactsLoadingState extends HospitalContactsState {}

class HospitalContactsListResultState extends HospitalContactsState {}

class AddHospitalContactsResultState extends HospitalContactsState {}

class DeleteHospitalContactsResultState extends HospitalContactsState {}

class HospitalContactsErrorState extends HospitalContactsState {
  final String error;
  final bool isAuthError;

  HospitalContactsErrorState({
    required this.error,
    required this.isAuthError,
  });
}
