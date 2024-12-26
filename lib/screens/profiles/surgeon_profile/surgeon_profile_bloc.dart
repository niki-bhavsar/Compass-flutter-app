import 'package:compass_software/data/entity/surgeon_detail_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../../data/service/model/call_result.dart';
import 'bloc/surgeon_profile_event.dart';
import 'bloc/surgeon_profile_state.dart';

class SurgeonProfileBloc extends Bloc<SurgeonProfileEvent, SurgeonProfileState> {
  final ProfilesRepository profilesRepository;
  SurgeonDetail? surgeonDetail;
  Map<String, String> trainingList = {};

  SurgeonProfileBloc({
    required this.profilesRepository,
  }) : super(SurgeonProfileInitialState()) {
    on<SurgeonProfileFetchEvent>(_handleHospitalProfileFetchEvent);
  }

  _handleHospitalProfileFetchEvent(
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

      trainingList = {
        "UnderGraduate": surgeonDetail?.training?.unGradName ?? "",
        "Medical School": surgeonDetail?.training?.medSchName ?? "",
        "Residency": surgeonDetail?.training?.medSchName ?? "",
        "Fellowship": surgeonDetail?.training?.medSchName ?? "",
        "Notes": surgeonDetail?.training?.medSchName ?? "",
      };
      emit(SurgeonProfileResultState());
    }
  }
}
