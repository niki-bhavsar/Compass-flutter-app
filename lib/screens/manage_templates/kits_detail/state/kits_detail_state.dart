import 'package:compass_software/data/entity/template_kits_detail_entiry.dart';

sealed class KitsDetailState {}

class KitsDetailInitialState extends KitsDetailState {}

class KitsDetailLoadingState extends KitsDetailState {}

class KitsDetailSuccessState extends KitsDetailState {
  final TemplateKitsDetailEntiry kitsDetail;

  KitsDetailSuccessState({required this.kitsDetail});
}

class KitsDetailErrorState extends KitsDetailState {
  final String error;
  final bool isAuthError;

  KitsDetailErrorState({
    required this.error,
    required this.isAuthError,
  });
}
