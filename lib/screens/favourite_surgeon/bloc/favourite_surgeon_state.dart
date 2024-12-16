import '../../../data/entity/base_entity.dart';

sealed class FavouriteSurgeonState {}

class FavouriteSurgeonInitialState extends FavouriteSurgeonState {}

class FavouriteSurgeonLoadingState extends FavouriteSurgeonState {}

class FavouriteSurgeonResultState extends FavouriteSurgeonState {}

class FavouriteSurgeonSaveDataSuccessState extends FavouriteSurgeonState {
  final BaseEntity entity;

  FavouriteSurgeonSaveDataSuccessState({
    required this.entity,
  });
}

class FavouriteSurgeonErrorState extends FavouriteSurgeonState {
  final String error;
  final bool isAuthError;

  FavouriteSurgeonErrorState({
    required this.error,
    required this.isAuthError,
  });
}
