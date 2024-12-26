import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/surgeon_notes_entity.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../../data/service/model/call_result.dart';
import 'bloc/surgeon_notes_event.dart';
import 'bloc/surgeon_notes_state.dart';

class SurgeonNotesBloc extends Bloc<SurgeonNotesEvent, SurgeonNotesState> {
  final ProfilesRepository profilesRepository;
  final String surgeonId;
  List<SurgeonNotesData> surgeonNotesList = [];

  SurgeonNotesBloc({
    required this.profilesRepository,
    required this.surgeonId,
  }) : super(SurgeonNotesInitialState()) {
    on<SurgeonNotesFetchEvent>(_handleSurgeonNotesFetchEvent);
  }

  _handleSurgeonNotesFetchEvent(
    SurgeonNotesFetchEvent event,
    Emitter<SurgeonNotesState> emit,
  ) async {
    emit(SurgeonNotesLoadingState());

    final result = await profilesRepository.getSurgeonNotes(surgeonId);
    if (result is Failure<SurgeonNotesEntity>) {
      emit(SurgeonNotesErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<SurgeonNotesEntity>) {
      surgeonNotesList.clear();
      surgeonNotesList.addAll(result.data.surgeonNotes);
      emit(SurgeonNotesResultState());
    }
  }
}
