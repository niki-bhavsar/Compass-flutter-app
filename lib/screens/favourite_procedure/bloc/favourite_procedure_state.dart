import '../../../data/entity/base_entity.dart';

sealed class FavouriteProcedureState {}

class FavouriteProcedureInitialState extends FavouriteProcedureState {}

class FavouriteProcedureLoadingState extends FavouriteProcedureState {}

class FavouriteProcedureSaveDataSuccessState extends FavouriteProcedureState {
  final BaseEntity entity;

  FavouriteProcedureSaveDataSuccessState({
    required this.entity,
  });
}

class FavouriteProcedureResultState extends FavouriteProcedureState {}

class FavouriteProcedureErrorState extends FavouriteProcedureState {
  final String error;
  final bool isAuthError;

  FavouriteProcedureErrorState({
    required this.error,
    required this.isAuthError,
  });
}
