import 'package:fpdart/fpdart.dart';
import 'package:sola_ev_test/core/failure.dart';
import 'package:sola_ev_test/data/datasources/ilocal_data_source.dart';
import 'package:sola_ev_test/data/datasources/inetwork_data_source.dart';
import 'package:sola_ev_test/data/models/station_model_mapper.dart';
import 'package:sola_ev_test/domain/entities/station.dart';
import 'package:sola_ev_test/domain/repositories/istations_repository.dart';

class StationsRepository implements IStationsRepository {
  final INetworkDataSource _networkDataSource;
  final ILocalDataSource _localDataSource;

  StationsRepository({
    required INetworkDataSource networkDataSource,
    required ILocalDataSource localDataSource,
  })  : _localDataSource = localDataSource,
        _networkDataSource = networkDataSource;

  @override
  Future<Either<Failure, List<Station>>> getAllStations() async {
    try {
      final response = await _networkDataSource.getAllStations();

      final result = response.map((responseModel) {
        final ids = _localDataSource.getLikedStationsIds();
        final isFavorite = ids?.contains(responseModel.id) ?? false;
        return responseModel.toStation(isFavorite);
      }).toList();

      return Either.right(result);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Station>> getStationById(String id) async {
    try {
      final response = await _networkDataSource.getStationById(id);
      if (response == null) {
        return Either.left(ServerFailure("Can't find such station"));
      } else {
        final ids = _localDataSource.getLikedStationsIds();
        final isFavorite = ids?.contains(response.id) ?? false;
        final result = response.toStation(isFavorite);

        return Either.right(result);
      }
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Station>>> getLikedStations() async {
    try {
      final ids = _localDataSource.getLikedStationsIds() ?? [];
      final response = await _networkDataSource.getLikedStations(ids);

      if (response == null) {
        return Either.left(ServerFailure("Can't find any station"));
      } else {
        // I hardcoded true here because we're working ONLY with liked ones
        // in this function
        final result = response
            .map((responseModel) => responseModel.toStation(true))
            .toList();

        return Either.right(result);
      }
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleLikeStation(String id) async {
    try {
      final result = await _localDataSource.toggleLikeStation(id);
      return Either.right(result);
    } catch (e) {
      return Either.left(CacheFailure(e.toString()));
    }
  }
}
