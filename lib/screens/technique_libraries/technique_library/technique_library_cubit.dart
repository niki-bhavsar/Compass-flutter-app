import 'package:compass_software/data/entity/technique_library_entity.dart';
import 'package:compass_software/data/repository/settings_repository.dart';
import 'package:compass_software/data/service/model/call_result.dart';
import 'package:compass_software/screens/technique_libraries/technique_library/state/technique_library_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechniqueLibraryCubit extends Cubit<TechniqueLibraryState> {
  final SettingsRepository settingsRepository;
  late List<TechniqueLibraryInfo> techlibraries = [];
  TechniqueLibraryCubit({required this.settingsRepository})
      : super(TechniqueLibraryInitialState()) {
    fetchTechniqueLibraryData();
  }

  void fetchTechniqueLibraryData() async {
    emit(TechniqueLibraryLoadingState());
    CallResult<TechniqueLibraryEntity> response = await settingsRepository.getTechniqueLibraries();

    if (response is Failure<TechniqueLibraryEntity>) {
      emit(TechniqueLibraryErrorState(
        error: response.cause,
        code: response.code,
      ));
    } else if (response is Success<TechniqueLibraryEntity>) {
      techlibraries = response.data.values;
      emit(TechniqueLibrarySuccessState(techlibraries: response.data.values));
    }
  }

  void serchTechniqueLibrary(String txtSearch) async {
    if (txtSearch.trim().isEmpty) {
      emit(TechniqueLibrarySuccessState(techlibraries: techlibraries));
    } else {
      final filtered = techlibraries.where((element) {
        return element.title.toLowerCase().contains(txtSearch.toLowerCase());
      }).toList();
      emit(TechniqueLibrarySuccessState(techlibraries: filtered));
    }
  }
}
