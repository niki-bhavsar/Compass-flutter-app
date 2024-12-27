sealed class HospitalProfileState {}

class HospitalProfileInitialState extends HospitalProfileState {}

class HospitalProfileLoadingState extends HospitalProfileState {}

class HospitalProfileResultState extends HospitalProfileState {}

class HospitalProfileErrorState extends HospitalProfileState {
  final String error;
  final bool isAuthError;

  HospitalProfileErrorState({
    required this.error,
    required this.isAuthError,
  });
}
