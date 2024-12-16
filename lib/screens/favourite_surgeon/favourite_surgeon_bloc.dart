import 'package:collection/collection.dart';
import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/repository/favourite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/favourite_surgeon_entity.dart';
import '../../data/service/model/call_result.dart';
import 'bloc/favourite_surgeon_event.dart';
import 'bloc/favourite_surgeon_state.dart';

class FavouriteSurgeonBloc extends Bloc<FavouriteSurgeonEvent, FavouriteSurgeonState> {
  final FavouriteRepository favouriteRepository;

  int favouriteCount = 1;

  // This has list of all surgeons
  List<SurgeonList> surgeonsList = [];

  // This has list of selected surgeons
  List<SurgeonList> selectedSurgeonList = [];

  FavouriteSurgeonBloc({
    required this.favouriteRepository,
  }) : super(FavouriteSurgeonInitialState()) {
    on<FavouriteSurgeonFetchEvent>(_handleFavouriteSurgeonListFetchEvent);
    on<FavouriteSurgeonSaveEvent>(_handleFavouriteSurgeonsSaveEvent);
  }

  List<SurgeonList> getSurgeonsList() {
    return surgeonsList
        .where((element) =>
            selectedSurgeonList.firstWhereOrNull((b) => b.surgeonId == element.surgeonId) == null)
        .toList();
  }

  _handleFavouriteSurgeonListFetchEvent(
    FavouriteSurgeonFetchEvent event,
    Emitter<FavouriteSurgeonState> emit,
  ) async {
    emit(FavouriteSurgeonLoadingState());

    final result = await favouriteRepository.getFavoriteSurgeon();
    if (result is Failure<FavouriteSurgeonEntity>) {
      emit(FavouriteSurgeonErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<FavouriteSurgeonEntity>) {
      surgeonsList = result.data.surgeons;

      favouriteCount = result.data.favouriteSurgeons.length;

      selectedSurgeonList.clear();
      selectedSurgeonList.addAll(result.data.favouriteSurgeons.toList());

      emit(FavouriteSurgeonResultState());
    }
  }

  _handleFavouriteSurgeonsSaveEvent(
    FavouriteSurgeonSaveEvent event,
    Emitter<FavouriteSurgeonState> emit,
  ) async {
    emit(FavouriteSurgeonLoadingState());

    final result = await favouriteRepository.saveFavoriteSurgeon(
      surgeons: selectedSurgeonList,
    );
    if (result is Failure<BaseEntity>) {
      emit(FavouriteSurgeonErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<BaseEntity>) {
      emit(FavouriteSurgeonSaveDataSuccessState(entity: result.data));
    }
  }
}
