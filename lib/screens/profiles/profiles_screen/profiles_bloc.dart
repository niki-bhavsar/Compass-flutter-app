import 'package:compass_software/data/entity/hospital_entity.dart';
import 'package:compass_software/data/entity/surgeon_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../../data/service/model/call_result.dart';
import 'bloc/profiles_event.dart';
import 'bloc/profiles_state.dart';

class ProfilesBloc extends Bloc<ProfilesEvent, ProfilesState> {
  final ProfilesRepository profilesRepository;
  List<HospitalData> hospitalList = [];
  List<SurgeonData> surgeonList = [];

  ProfilesBloc({
    required this.profilesRepository,
  }) : super(ProfilesInitialState()) {
    on<HospitalsListFetchEvent>(_handleHospitalListFetchEvent);
    on<SurgeonsListFetchEvent>(_handleSurgeonListFetchEvent);
  }

  _handleHospitalListFetchEvent(
    HospitalsListFetchEvent event,
    Emitter<ProfilesState> emit,
  ) async {
    emit(ProfilesLoadingState());

    final result = await profilesRepository.getHospitalList();
    if (result is Failure<HospitalEntity>) {
      emit(ProfilesErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<HospitalEntity>) {
      hospitalList.clear();
      hospitalList.addAll(result.data.hospitals.toList());

      emit(ProfileFetchHospitalListState());
    }
  }

  _handleSurgeonListFetchEvent(
    SurgeonsListFetchEvent event,
    Emitter<ProfilesState> emit,
  ) async {
    emit(ProfilesLoadingState());

    final result = await profilesRepository.getSurgeonList();
    if (result is Failure<SurgeonEntity>) {
      emit(ProfilesErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<SurgeonEntity>) {
      surgeonList.clear();
      surgeonList.addAll(result.data.surgeons.toList());

      emit(ProfileFetchSurgeonListState());
    }
  }
}
