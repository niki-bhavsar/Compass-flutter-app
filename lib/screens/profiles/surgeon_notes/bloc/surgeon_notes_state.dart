sealed class SurgeonNotesState {}

class SurgeonNotesInitialState extends SurgeonNotesState {}

class SurgeonNotesLoadingState extends SurgeonNotesState {}

class SurgeonNotesResultState extends SurgeonNotesState {}

class SurgeonNotesErrorState extends SurgeonNotesState {
  final String error;
  final bool isAuthError;

  SurgeonNotesErrorState({
    required this.error,
    required this.isAuthError,
  });
}
