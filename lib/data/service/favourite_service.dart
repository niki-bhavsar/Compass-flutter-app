import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/entity/favourite_hospital_entity.dart';
import 'package:compass_software/data/entity/favourite_procedure_entity.dart';

import '../entity/favourite_surgeon_entity.dart';
import 'base_service.dart';
import 'model/call_result.dart';

class FavouriteService extends BaseService {
  Future<CallResult<FavouriteSurgeonEntity>> getFavoriteSurgeon() {
    final uri = toApiUri("favorites");
    return safeGetApiCall<FavouriteSurgeonEntity>(
      uri: uri,
      jsonParser: favouriteSurgeonEntityFromJson,
    );
  }

  Future<CallResult<BaseEntity>> saveFavoriteSurgeon({
    required List<SurgeonList> surgeons,
  }) {
    final params = <String, dynamic>{
      "surgeons": surgeons.map((e) => e.toJson()).toList(),
    };
    final uri = toApiUri("savefavorites");
    return safePostApiCall<BaseEntity>(
      uri: uri,
      jsonParser: baseEntityFromJson,
      params: params,
    );
  }

  Future<CallResult<FavouriteHospitalEntity>> getFavoriteHospital() {
    final uri = toApiUri("favorites");
    return safeGetApiCall<FavouriteHospitalEntity>(
      uri: uri,
      jsonParser: favouriteHospitalEntityFromJson,
    );
  }

  Future<CallResult<BaseEntity>> saveFavoriteHospital({
    required List<HospitalList> hospitals,
  }) {
    final params = <String, dynamic>{
      "hospitals": hospitals.map((e) => e.toJson()).toList(),
    };
    final uri = toApiUri("savefavorites");
    return safePostApiCall<BaseEntity>(
      uri: uri,
      jsonParser: baseEntityFromJson,
      params: params,
    );
  }

  Future<CallResult<FavouriteProcedureEntity>> getFavoriteProcedure() {
    final uri = toApiUri("favoriteprocedure");
    return safeGetApiCall<FavouriteProcedureEntity>(
      uri: uri,
      jsonParser: favouriteProcedureEntityFromJson,
    );
  }

  Future<CallResult<BaseEntity>> saveFavoriteProcedure({
    required List<ProcedureList> procedures,
  }) {
    final params = <String, dynamic>{
      "procedures": procedures.map((e) => e.toJson()).toList(),
    };
    final uri = toApiUri("savefavoriteprocedure");
    return safePostApiCall<BaseEntity>(
      uri: uri,
      jsonParser: baseEntityFromJson,
      params: params,
    );
  }
}
