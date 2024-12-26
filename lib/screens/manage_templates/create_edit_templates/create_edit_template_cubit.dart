import 'package:collection/collection.dart';
import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/entity/template_implant_instrument_filtercategory.dart';
import 'package:compass_software/data/entity/template_implants_intrument_entity.dart';
import 'package:compass_software/data/entity/templates_list_entity.dart';
import 'package:compass_software/data/repository/settings_repository.dart';
import 'package:compass_software/data/service/model/call_result.dart';
import 'package:compass_software/screens/manage_templates/create_edit_templates/state/create_edit_template_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEditTemplateCubit extends Cubit<CreateEditTemplateState> {
  final formKey = GlobalKey<FormState>();
  final SettingsRepository settingsRepository;
  final TemplateListInfo? templateDetails;

  List<TemplatesFilterList> filterList = [];

  ImplantInstrumentEntity? allImplantInstrumentEntity;
  ImplantInstrumentEntity? implantInstrumentEntity;

  String selectedCategoryName = "All";
  bool isEditMode = false;
  bool shouldDisplaySelected = false;
  int selectedMenu = 0;

  Map<String?, ImplantValue> selectedImplants = {};
  Map<String?, ImplantValue> selectedInstruments = {};

  final TextEditingController templateName = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  CreateEditTemplateCubit({
    required this.settingsRepository,
    required this.templateDetails,
  }) : super(CreateEditTemplateInitialState()) {
    isEditMode = templateDetails != null;
    templateName.text = templateDetails?.name ?? "";
  }

  int getSelectedItemsLength() {
    return selectedImplants.length + selectedInstruments.length;
  }

  setSelectedMenu(int index) {
    emit(CreateEditTemplateLoadingState());
    selectedMenu = index;
    emit(CreateEditTemplateFetchImplantInstrumentSuccessState());
  }

  fetchImplantInstrumentData() async {
    emit(CreateEditTemplateLoadingState());
    final response = await settingsRepository.getDefaultImplantsInstruments();
    if (response is Failure<TemplateImplantInstrumentEntity>) {
      emit(CreateEditTemplateErrorState(
        error: response.cause,
        isAuthError: response.isAuthError(),
      ));
    } else if (response is Success<TemplateImplantInstrumentEntity>) {
      final templateDetail = response.data.values;
      filterList = templateDetail?.filterList ?? [];

      implantInstrumentEntity = templateDetail?.allKits;
      allImplantInstrumentEntity = templateDetail?.allKits;
      if (isEditMode) {
        fetchSelectedKitsForEditTemplate();
      } else {
        final state = CreateEditTemplateFetchImplantInstrumentSuccessState();
        emit(state);
      }
    }
  }

  fetchSelectedKitsForEditTemplate() async {
    final response =
        await settingsRepository.getImplantsInstrumentsforTemplate(templateDetails?.id ?? "");
    if (response is Failure<ImplantInstrumentEditTemplateEntity>) {
      emit(CreateEditTemplateErrorState(
        error: response.cause,
        isAuthError: response.isAuthError(),
      ));
    } else if (response is Success<ImplantInstrumentEditTemplateEntity>) {
      final implants = response.data.values?.implants ?? [];
      final instruments = response.data.values?.instruments ?? [];
      for (var selectedItem in implants) {
        for (var kitsDetail in selectedItem.values) {
          for (var implant in kitsDetail.list) {
            updateImplantInstrument(implant, true, true);
          }
        }

        for (var selectedItem in instruments) {
          for (var kitsDetail in selectedItem.values) {
            for (var instrument in kitsDetail.list) {
              updateImplantInstrument(instrument, true, false);
            }
          }
        }
        emit(CreateEditTemplateFetchImplantInstrumentSuccessState());
      }
    }
  }

  fetchImplantInstrumentDataForCategory(
    String? categoryName,
    String parentId,
    String childId,
  ) async {
    implantInstrumentEntity = null;
    emit(CreateEditTemplateLoadingState());
    selectedCategoryName = categoryName ?? "";
    final response = await settingsRepository.getImplantsInstrumentsforCategory(parentId, childId);
    if (response is Failure<TemplateImplantInstrumentFiltercategory>) {
      emit(CreateEditTemplateErrorState(
        error: response.cause,
        isAuthError: response.isAuthError(),
      ));
    } else if (response is Success<TemplateImplantInstrumentFiltercategory>) {
      implantInstrumentEntity = response.data.implantInstruments;
      emit(CreateEditTemplateFetchImplantInstrumentSuccessState());
    }
  }

  void handleSaveTemplateEvent() async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      implantInstrumentEntity = null;
      emit(CreateEditTemplateLoadingState());
      final templateTitle = templateName.text.trim();
      final List<String> implantIds =
          selectedImplants.values.map((implant) => implant.id).whereType<String>().toList();
      final List<String> instrumentIds =
          selectedImplants.values.map((instrument) => instrument.id).whereType<String>().toList();

      CallResult<BaseEntity> response = await settingsRepository.createEditTemplate(
          templateDetails?.id, templateTitle, implantIds, instrumentIds);

      if (response is Failure<BaseEntity>) {
        emit(CreateEditTemplateErrorState(
          error: response.cause,
          isAuthError: response.isAuthError(),
        ));
      } else if (response is Success<BaseEntity>) {
        emit(CreateEditTemplateNewCreatedState());
      }
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }

  void setDefaultAllData() {
    emit(CreateEditTemplateLoadingState());
    implantInstrumentEntity = allImplantInstrumentEntity;
    shouldDisplaySelected = false;
    emit(CreateEditTemplateFetchImplantInstrumentSuccessState());
  }

  void setDefaultSelectedData() {
    emit(CreateEditTemplateLoadingState());

    final newImplants = <ImplantEntity>[];
    final implants = allImplantInstrumentEntity?.implants ?? [];
    for (var implant in implants) {
      final values = implant.values.where((element) {
        return element.list.firstWhereOrNull((b) => selectedImplants.containsKey(b.id)) != null;
      }).toList();

      if (values.isNotEmpty) {
        newImplants.add(ImplantEntity(
          manufacturerId: implant.manufacturerId,
          manufacturerName: implant.manufacturerName,
          values: values,
        ));
      }
    }

    final newInstruments = <ImplantEntity>[];
    final instruments = allImplantInstrumentEntity?.instruments ?? [];
    for (var instrument in instruments) {
      final values = instrument.values.where((element) {
        return element.list.firstWhereOrNull((b) => selectedInstruments.containsKey(b.id)) != null;
      }).toList();

      if (values.isNotEmpty) {
        newInstruments.add(ImplantEntity(
          manufacturerId: instrument.manufacturerId,
          manufacturerName: instrument.manufacturerName,
          values: values,
        ));
      }
    }

    implantInstrumentEntity = ImplantInstrumentEntity();
    implantInstrumentEntity?.implants = newImplants;
    implantInstrumentEntity?.instruments = newInstruments;
    shouldDisplaySelected = true;
    emit(CreateEditTemplateFetchImplantInstrumentSuccessState());
  }

  bool isSelected(ImplantValue item, bool isImplant) {
    if (isImplant) {
      return selectedImplants.containsKey(item.id);
    } else {
      return selectedInstruments.containsKey(item.id);
    }
  }

  void updateImplantInstrument(ImplantValue item, bool isSelected, bool isImplant) {
    emit(CreateEditTemplateLoadingState());
    if (isImplant) {
      if (!selectedImplants.containsKey(item.id)) {
        selectedImplants[item.id] = item;
      } else {
        selectedImplants.remove(item.id);
      }
    } else {
      if (isSelected) {
        selectedInstruments[item.id] = item;
      } else {
        selectedInstruments.remove(item.id);
      }
    }
    emit(CreateEditTemplateInitialState());
  }
}
