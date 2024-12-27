sealed class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesResultState extends NotesState {}

class NotesErrorState extends NotesState {
  final String error;
  final bool isAuthError;

  NotesErrorState({
    required this.error,
    required this.isAuthError,
  });
}
