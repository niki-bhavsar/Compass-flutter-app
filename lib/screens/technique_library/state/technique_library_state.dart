import 'package:compass_software/data/entity/technique_library_entity.dart';

sealed class TechniqueLibraryState {}

class TechniqueLibraryInitialState extends TechniqueLibraryState {}

class TechniqueLibraryLoadingState extends TechniqueLibraryState {}

class TechniqueLibrarySuccessState extends TechniqueLibraryState {
  final List<TechniqueLibraryInfo> techlibraries;

  TechniqueLibrarySuccessState({required this.techlibraries});
}

class TechniqueLibraryErrorState extends TechniqueLibraryState {
  final String error;
  final int code;
  TechniqueLibraryErrorState({
    required this.error,
    required this.code,
  });
}
