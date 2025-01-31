import 'package:fpdart/src/either.dart';
import 'package:sola_ev_test/core/failure.dart';
import 'package:sola_ev_test/data/datasources/inetwork_data_source.dart';
import 'package:sola_ev_test/data/models/station_model_mapper.dart';
import 'package:sola_ev_test/domain/entities/station.dart';
import 'package:sola_ev_test/domain/repositories/istations_repository.dart';

class StationsRepository implements IStationsRepository {
  final INetworkDataSource networkDataSource;

  StationsRepository({required this.networkDataSource});

  @override
  Future<Either<Failure, List<Station>>> getAllStations() async {
    try {
      final response = await networkDataSource.getAllStations();

      final result = response
          // TODO(eliahu): add favorites after adding a logic of saving
          .map((responseModel) => responseModel.toStation(false))
          .toList();

      return Either.right(result);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Station>> getStationById(String id) async {
    try {
      final response = await networkDataSource.getStationById(id);

      if (response == null) {
        return Either.left(ServerFailure("Can't find such station"));
      } else {
        // TODO(eliahu): add favorites after adding a logic of saving
        final result = response.toStation(false);

        return Either.right(result);
      }
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
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
