import 'package:collection/collection.dart';
import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/repository/favourite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/favourite_hospital_entity.dart';
import '../../data/service/model/call_result.dart';
import 'bloc/favourite_hospital_event.dart';
import 'bloc/favourite_hospital_state.dart';

class FavouriteHospitalBloc extends Bloc<FavouriteHospitalEvent, FavouriteHospitalState> {
  final FavouriteRepository favouriteRepository;

  int favouriteCount = 1;

  // This has list of all hospital
  List<HospitalList> hospitalList = [];

  // This has list of selected hospital
  List<HospitalList> selectedHospitalList = [];

  FavouriteHospitalBloc({
    required this.favouriteRepository,
  }) : super(FavouriteHospitalInitialState()) {
    on<FavouriteHospitalFetchEvent>(_handleFavouriteHospitalListFetchEvent);
    on<FavouriteHospitalSaveEvent>(_handleFavouriteHospitalSaveEvent);
  }

  List<HospitalList> getHospitalList() {
    return hospitalList
        .where((element) =>
            selectedHospitalList.firstWhereOrNull((b) => b.hospitalId == element.hospitalId) ==
            null)
        .toList();
  }

  _handleFavouriteHospitalListFetchEvent(
    FavouriteHospitalFetchEvent event,
    Emitter<FavouriteHospitalState> emit,
  ) async {
    emit(FavouriteHospitalLoadingState());

    final result = await favouriteRepository.getFavoriteHospital();
    if (result is Failure<FavouriteHospitalEntity>) {
      emit(FavouriteHospitalErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<FavouriteHospitalEntity>) {
      hospitalList = result.data.hospitals;

      favouriteCount = result.data.favouriteHospitals.length;

      selectedHospitalList.clear();
      selectedHospitalList.addAll(result.data.favouriteHospitals.toList());

      emit(FavouriteHospitalResultState());
    }
  }

  _handleFavouriteHospitalSaveEvent(
    FavouriteHospitalSaveEvent event,
    Emitter<FavouriteHospitalState> emit,
  ) async {
    emit(FavouriteHospitalLoadingState());

    final result = await favouriteRepository.saveFavoriteHospital(hospitals: selectedHospitalList);
    if (result is Failure<BaseEntity>) {
      emit(FavouriteHospitalErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<BaseEntity>) {
      emit(FavouriteHospitalSaveDataSuccessState(entity: result.data));
    }
  }
}
