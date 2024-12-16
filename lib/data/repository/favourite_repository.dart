import 'package:compass_software/data/entity/favourite_hospital_entity.dart';
import 'package:compass_software/data/entity/favourite_procedure_entity.dart';
import 'package:compass_software/data/service/favourite_service.dart';

import '../entity/base_entity.dart';
import '../entity/favourite_surgeon_entity.dart';
import '../service/model/call_result.dart';
import '../shared_pref/session_pref.dart';

abstract interface class FavouriteRepository {
  Future<CallResult<FavouriteSurgeonEntity>> getFavoriteSurgeon();

  Future<CallResult<BaseEntity>> saveFavoriteSurgeon({
    required List<SurgeonList> surgeons,
  });

  Future<CallResult<FavouriteHospitalEntity>> getFavoriteHospital();

  Future<CallResult<BaseEntity>> saveFavoriteHospital({
    required List<HospitalList> hospitals,
  });

  Future<CallResult<FavouriteProcedureEntity>> getFavoriteProcedure();

  Future<CallResult<BaseEntity>> saveFavoriteProcedure({
    required List<ProcedureList> procedures,
  });
}

base class FavouriteRepositoryImpl implements FavouriteRepository {
  final SessionPref sessionPref;
  final FavouriteService favouriteService;

  FavouriteRepositoryImpl({
    required this.sessionPref,
    required this.favouriteService,
  });

  @override
  Future<CallResult<FavouriteSurgeonEntity>> getFavoriteSurgeon() {
    return favouriteService.getFavoriteSurgeon();
  }

  @override
  Future<CallResult<BaseEntity>> saveFavoriteSurgeon({
    required List<SurgeonList> surgeons,
  }) {
    return favouriteService.saveFavoriteSurgeon(
      surgeons: surgeons,
    );
  }

  @override
  Future<CallResult<FavouriteHospitalEntity>> getFavoriteHospital() {
    return favouriteService.getFavoriteHospital();
  }

  @override
  Future<CallResult<BaseEntity>> saveFavoriteHospital({
    required List<HospitalList> hospitals,
  }) {
    return favouriteService.saveFavoriteHospital(
      hospitals: hospitals,
    );
  }

  @override
  Future<CallResult<FavouriteProcedureEntity>> getFavoriteProcedure() {
    return favouriteService.getFavoriteProcedure();
  }

  @override
  Future<CallResult<BaseEntity>> saveFavoriteProcedure({
    required List<ProcedureList> procedures,
  }) {
    return favouriteService.saveFavoriteProcedure(
      procedures: procedures,
    );
  }
}
