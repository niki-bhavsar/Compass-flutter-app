import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/hospital_detail_entity.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../../data/service/model/call_result.dart';
import 'bloc/hospital_profile_event.dart';
import 'bloc/hospital_profile_state.dart';

class HospitalProfileBloc extends Bloc<HospitalProfileEvent, HospitalProfileState> {
  final ProfilesRepository profilesRepository;
  HospitalDetail? hospitalDetail;

  HospitalProfileBloc({
    required this.profilesRepository,
  }) : super(HospitalProfileInitialState()) {
    on<HospitalsProfileFetchEvent>(_handleHospitalProfileFetchEvent);
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
}
