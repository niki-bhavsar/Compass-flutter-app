import 'package:compass_software/data/entity/templates_list_entity.dart';
import 'package:compass_software/data/repository/settings_repository.dart';
import 'package:compass_software/data/service/model/call_result.dart';
import 'package:compass_software/screens/manage_templates/template_list/state/templates_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemplatesListCubit extends Cubit<TemplatesListState> {
  final SettingsRepository settingsRepository;

  TemplatesListCubit({required this.settingsRepository}) : super(TemplateListInitialState()) {
    fetchTemplatesListData();
  }

  void fetchTemplatesListData() async {
    emit(TemplateListLoadingState());
    CallResult<TemplateListEntity> response = await settingsRepository.getTemplatesList();

    if (response is Failure<TemplateListEntity>) {
      emit(TemplateListErrorState(
        error: response.cause,
        isAuthError: response.isAuthError(),
      ));
    } else if (response is Success<TemplateListEntity>) {
      emit(TemplateListSuccessState(templateListEntity: response.data.values));
    }
  }
}
