import 'package:compass_software/data/entity/favourite_procedure_entity.dart';
import 'package:compass_software/data/repository/favourite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/base_entity.dart';
import '../../data/service/model/call_result.dart';
import 'bloc/favourite_procedure_event.dart';
import 'bloc/favourite_procedure_state.dart';

class FavouriteProcedureBloc extends Bloc<FavouriteProcedureEvent, FavouriteProcedureState> {
  final FavouriteRepository favouriteRepository;

  int favouriteCount = 1;

  // This has list of all procedure
  List<Procedure> procedureList = [];

  // This has list of selected procedure
  List<ProcedureList> selectedProcedureList = [];

  FavouriteProcedureBloc({
    required this.favouriteRepository,
  }) : super(FavouriteProcedureInitialState()) {
    on<FavouriteProcedureFetchEvent>(_handleFavouriteProcedureListFetchEvent);
    on<FavouriteProcedureSaveEvent>(_handleFavouriteProcedureSaveEvent);
  }

  _handleFavouriteProcedureListFetchEvent(
    FavouriteProcedureFetchEvent event,
    Emitter<FavouriteProcedureState> emit,
  ) async {
    emit(FavouriteProcedureLoadingState());

    final result = await favouriteRepository.getFavoriteProcedure();
    if (result is Failure<FavouriteProcedureEntity>) {
      emit(FavouriteProcedureErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<FavouriteProcedureEntity>) {
      favouriteCount = result.data.favouriteProcedure.length;

      selectedProcedureList.clear();
      selectedProcedureList.addAll(result.data.favouriteProcedure.toList());

      procedureList.clear();
      procedureList.addAll(result.data.procedures.toList());

      emit(FavouriteProcedureResultState());
    }
  }

  _handleFavouriteProcedureSaveEvent(
    FavouriteProcedureSaveEvent event,
    Emitter<FavouriteProcedureState> emit,
  ) async {
    emit(FavouriteProcedureLoadingState());

    final result =
        await favouriteRepository.saveFavoriteProcedure(procedures: selectedProcedureList);
    if (result is Failure<BaseEntity>) {
      emit(FavouriteProcedureErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<BaseEntity>) {
      emit(FavouriteProcedureSaveDataSuccessState(entity: result.data));
    }
  }
}
