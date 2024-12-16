import '../../../data/entity/base_entity.dart';

sealed class FavouriteHospitalState {}

class FavouriteHospitalInitialState extends FavouriteHospitalState {}

class FavouriteHospitalLoadingState extends FavouriteHospitalState {}

class FavouriteHospitalResultState extends FavouriteHospitalState {}

class FavouriteHospitalSaveDataSuccessState extends FavouriteHospitalState {
  final BaseEntity entity;

  FavouriteHospitalSaveDataSuccessState({
    required this.entity,
  });
}

class FavouriteHospitalErrorState extends FavouriteHospitalState {
  final String error;
  final bool isAuthError;

  FavouriteHospitalErrorState({
    required this.error,
    required this.isAuthError,
  });
}
