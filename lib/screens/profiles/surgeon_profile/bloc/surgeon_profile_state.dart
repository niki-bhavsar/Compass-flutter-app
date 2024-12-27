sealed class SurgeonProfileState {}

class SurgeonProfileInitialState extends SurgeonProfileState {}

class SurgeonProfileLoadingState extends SurgeonProfileState {}

class SurgeonProfileResultState extends SurgeonProfileState {}

class SurgeonEventsResultState extends SurgeonProfileState {}

class SurgeonProfileErrorState extends SurgeonProfileState {
  final String error;
  final bool isAuthError;

  SurgeonProfileErrorState({
    required this.error,
    required this.isAuthError,
  });
}
