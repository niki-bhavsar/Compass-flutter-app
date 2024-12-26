sealed class CreateEditTemplateState {}

class CreateEditTemplateInitialState extends CreateEditTemplateState {}

class CreateEditTemplateLoadingState extends CreateEditTemplateState {}

class CreateEditTemplateFetchImplantInstrumentSuccessState extends CreateEditTemplateState {
  CreateEditTemplateFetchImplantInstrumentSuccessState();
}

class CreateEditTemplateNewCreatedState extends CreateEditTemplateState {}

class CreateEditTemplateErrorState extends CreateEditTemplateState {
  final String error;
  final bool isAuthError;

  CreateEditTemplateErrorState({
    required this.error,
    required this.isAuthError,
  });
}
