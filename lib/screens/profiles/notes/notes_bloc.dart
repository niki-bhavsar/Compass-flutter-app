import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/notes_entity.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../../data/service/model/call_result.dart';
import 'bloc/notes_event.dart';
import 'bloc/notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final ProfilesRepository profilesRepository;
  final bool isSurgeon;
  final String id;
  List<NotesData> notesList = [];

  NotesBloc({required this.profilesRepository, required this.id, required this.isSurgeon})
      : super(NotesInitialState()) {
    isSurgeon == true
        ? on<NotesFetchEvent>(_handleSurgeonNotesFetchEvent)
        : on<NotesFetchEvent>(_handleHospitalNotesFetchEvent);
  }

  _handleHospitalNotesFetchEvent(
    NotesFetchEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState());

    final result = await profilesRepository.getHospitalNotes(id);
    if (result is Failure<NotesEntity>) {
      emit(NotesErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<NotesEntity>) {
      notesList.clear();
      notesList.addAll(result.data.notes);
      emit(NotesResultState());
    }
  }

  _handleSurgeonNotesFetchEvent(
    NotesFetchEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState());

    final result = await profilesRepository.getSurgeonNotes(id);
    if (result is Failure<NotesEntity>) {
      emit(NotesErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<NotesEntity>) {
      notesList.clear();
      notesList.addAll(result.data.notes);
      emit(NotesResultState());
    }
  }
}
