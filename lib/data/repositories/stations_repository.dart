import 'package:fpdart/src/either.dart';
import 'package:sola_ev_test/core/failure.dart';
import 'package:sola_ev_test/domain/entities/station.dart';
import 'package:sola_ev_test/domain/repositories/istations_repository.dart';

class StationsRepository implements IStationsRepository {
  @override
  Future<Either<Failure, List<Station>>> getAllStations() {
    // TODO: implement getAllStations
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Station>> getStationById(String id) {
    // TODO: implement getItemById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Station>>> getLikedStations() {
    // TODO: implement getLikedStations
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> toggleLikeStation(String id) {
    // TODO: implement toggleLikeStation
    throw UnimplementedError();
  }
}
