import 'package:fpdart/fpdart.dart';
import 'package:sola_ev_test/domain/entities/station.dart';

import '../../core/export.dart';

abstract interface class IStationsRepository {
  Future<Either<Failure, List<Station>>> getAllStations();

  Future<Either<Failure, Station>> getStationById(String id);

  Future<Either<Failure, List<Station>>> getLikedStations();

  Future<Either<Failure, void>> toggleLikeStation(String id);
}
