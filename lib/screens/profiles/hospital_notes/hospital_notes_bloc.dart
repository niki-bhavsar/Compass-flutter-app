import 'package:compass_software/data/entity/hospital_notes_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../../data/service/model/call_result.dart';
import 'bloc/hospital_notes_event.dart';
import 'bloc/hospital_notes_state.dart';

class HospitalNotesBloc extends Bloc<HospitalNotesEvent, HospitalNotesState> {
  final ProfilesRepository profilesRepository;
  final String hospitalId;
  List<HospitalNotesData> hospitalNotesList = [];

  HospitalNotesBloc({
    required this.profilesRepository,
    required this.hospitalId,
  }) : super(HospitalNotesInitialState()) {
    on<HospitalsNotesFetchEvent>(_handleHospitalNotesFetchEvent);
  }

  _handleHospitalNotesFetchEvent(
    HospitalsNotesFetchEvent event,
    Emitter<HospitalNotesState> emit,
  ) async {
    emit(HospitalNotesLoadingState());

    final result = await profilesRepository.getHospitalNotes(hospitalId);
    if (result is Failure<HospitalNotesEntity>) {
      emit(HospitalNotesErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<HospitalNotesEntity>) {
      hospitalNotesList.clear();
      hospitalNotesList.addAll(result.data.hospitalNotes);
      emit(HospitalNotesResultState());
    }
  }
}
