import 'package:compass_software/data/entity/hospital_notes_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/hospital_detail_entity.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../../data/service/model/call_result.dart';
import 'bloc/hospital_profile_event.dart';
import 'bloc/hospital_profile_state.dart';

class HospitalProfileBloc extends Bloc<HospitalProfileEvent, HospitalProfileState> {
  final ProfilesRepository profilesRepository;
  HospitalDetail? hospitalDetail;
  List<HospitalNotesData> hospitalNotesList = [];

  HospitalProfileBloc({
    required this.profilesRepository,
  }) : super(HospitalProfileInitialState()) {
    on<HospitalsProfileFetchEvent>(_handleHospitalProfileFetchEvent);
    on<HospitalNotesFetchEvent>(_handleHospitalNotesFetchEvent);
  }

  _handleHospitalProfileFetchEvent(
    HospitalsProfileFetchEvent event,
    Emitter<HospitalProfileState> emit,
  ) async {
    emit(HospitalProfileLoadingState());

    final result = await profilesRepository.getHospitalDetails(event.hospitalId);
    if (result is Failure<HospitalDetailEntity>) {
      emit(HospitalProfileErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<HospitalDetailEntity>) {
      hospitalDetail = result.data.hospitalDetail;
      emit(HospitalProfileResultState());
    }
  }

  _handleHospitalNotesFetchEvent(
    HospitalNotesFetchEvent event,
    Emitter<HospitalProfileState> emit,
  ) async {
    emit(HospitalProfileLoadingState());

    final result = await profilesRepository.getHospitalNotes(event.hospitalId);
    if (result is Failure<HospitalNotesEntity>) {
      emit(HospitalProfileErrorState(
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
