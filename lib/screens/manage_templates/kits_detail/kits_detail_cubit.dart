import 'package:compass_software/data/entity/template_kits_detail_entiry.dart';
import 'package:compass_software/data/repository/settings_repository.dart';
import 'package:compass_software/data/service/model/call_result.dart';
import 'package:compass_software/screens/manage_templates/kits_detail/state/kits_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KitsDetailCubit extends Cubit<KitsDetailState> {
  final SettingsRepository settingsRepository;
  final String kitId;
  KitsDetailCubit(this.kitId, {required this.settingsRepository})
      : super(KitsDetailInitialState()) {
    fetchKitsDetail(kitId);
  }

  void fetchKitsDetail(String kitId) async {
    emit(KitsDetailLoadingState());
    CallResult<TemplateKitsDetailEntiry> response = await settingsRepository.getKitsDetails(kitId);
    if (response is Failure<TemplateKitsDetailEntiry>) {
      emit(
        KitsDetailErrorState(
          error: response.cause,
          isAuthError: response.isAuthError(),
        ),
      );
    } else if (response is Success<TemplateKitsDetailEntiry>) {
      emit(
        KitsDetailSuccessState(kitsDetail: response.data),
      );
    }
  }
}
