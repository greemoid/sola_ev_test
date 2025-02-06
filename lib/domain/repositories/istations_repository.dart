import 'package:fpdart/fpdart.dart';
import 'package:sola_ev_test/core/failure.dart';
import 'package:sola_ev_test/domain/entities/station.dart';

abstract interface class IStationsRepository {
  Future<Either<Failure, List<Station>>> getAllStations();

  Future<Either<Failure, Station>> getStationById(String id);

  Future<Either<Failure, List<Station>>> getLikedStations();

  Future<Either<Failure, bool>> toggleLikeStation(String id);
}
