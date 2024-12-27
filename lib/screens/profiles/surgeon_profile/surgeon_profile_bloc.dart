import 'package:compass_software/data/entity/surgeon_detail_entity.dart';
import 'package:compass_software/data/entity/surgeon_events_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../../data/service/model/call_result.dart';
import 'bloc/surgeon_profile_event.dart';
import 'bloc/surgeon_profile_state.dart';

class SurgeonProfileBloc extends Bloc<SurgeonProfileEvent, SurgeonProfileState> {
  final ProfilesRepository profilesRepository;
  SurgeonDetail? surgeonDetail;
  Map<String, List<SurgeonEvent>> events = {};

  SurgeonProfileBloc({
    required this.profilesRepository,
  }) : super(SurgeonProfileInitialState()) {
    on<SurgeonProfileFetchEvent>(_handleSurgeonProfileFetchEvent);
    on<SurgeonProfileEventsFetch>(_handleSurgeonProfileEventsFetch);
  }

  _handleSurgeonProfileFetchEvent(
    SurgeonProfileFetchEvent event,
    Emitter<SurgeonProfileState> emit,
  ) async {
    emit(SurgeonProfileLoadingState());

    final result = await profilesRepository.getSurgeonDetails(event.surgeonID);
    if (result is Failure<SurgeonDetailEntity>) {
      emit(SurgeonProfileErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<SurgeonDetailEntity>) {
      surgeonDetail = result.data.surgeonDetail;
      emit(SurgeonProfileResultState());
    }
  }

  _handleSurgeonProfileEventsFetch(
    SurgeonProfileEventsFetch event,
    Emitter<SurgeonProfileState> emit,
  ) async {
    emit(SurgeonProfileLoadingState());

    final result = await profilesRepository.getSurgeonEvents(event.surgeonID);
    if (result is Failure<SurgeonEventsEntity>) {
      emit(SurgeonProfileErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<SurgeonEventsEntity>) {
      if (result.data.futureEvents.isNotEmpty) {
        events["Future Events"] = result.data.futureEvents;
      }
      if (result.data.pastEvents.isNotEmpty) {
        events["Past Events"] = result.data.pastEvents;
      }

      emit(SurgeonEventsResultState());
    }
  }
}
