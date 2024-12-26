import 'package:compass_software/data/entity/templates_list_entity.dart';

sealed class TemplatesListState {}

class TemplateListInitialState extends TemplatesListState {}

class TemplateListLoadingState extends TemplatesListState {}

class TemplateListSuccessState extends TemplatesListState {
  final List<TemplateListInfo>? templateListEntity;

  TemplateListSuccessState({required this.templateListEntity});
}

class TemplateListErrorState extends TemplatesListState {
  final String error;
  final bool isAuthError;

  TemplateListErrorState({
    required this.error,
    required this.isAuthError,
  });
}
