import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sola_ev_test/core/failure.dart';
import 'package:sola_ev_test/domain/entities/station.dart';
import 'package:sola_ev_test/domain/repositories/istations_repository.dart';

import 'station_list_mock.dart';
import 'station_mock.dart';

class MockStationsRepository extends Mock implements IStationsRepository {
  @override
  Future<Either<Failure, List<Station>>> getAllStations() async {
    try {
      return Either.right(stationListMock);
    } catch (e) {
      return Either.left(ServerFailure('Server failure'));
    }
  }

  @override
  Future<Either<Failure, Station>> getStationById(String id) async {
    try {
      return Either.right(stationMock);
    } catch (e) {
      return Either.left(ServerFailure('Server failure'));
    }
  }
}
