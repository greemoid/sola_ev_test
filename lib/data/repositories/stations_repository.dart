import 'package:fpdart/fpdart.dart';
import 'package:sola_ev_test/core/failure.dart';
import 'package:sola_ev_test/data/datasources/ilocal_data_source.dart';
import 'package:sola_ev_test/data/datasources/inetwork_data_source.dart';
import 'package:sola_ev_test/data/models/station_model_mapper.dart';
import 'package:sola_ev_test/domain/entities/station.dart';
import 'package:sola_ev_test/domain/repositories/istations_repository.dart';

class StationsRepository implements IStationsRepository {
  final INetworkDataSource networkDataSource;
  final ILocalDataSource localDataSource;

  StationsRepository({
    required this.networkDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Station>>> getAllStations() async {
    try {
      final response = await networkDataSource.getAllStations();

      final result = response.map((responseModel) {
        final ids = localDataSource.getLikedStationsIds();
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
      final response = await networkDataSource.getStationById(id);
      if (response == null) {
        return Either.left(ServerFailure("Can't find such station"));
      } else {
        final ids = localDataSource.getLikedStationsIds();
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
      final ids = localDataSource.getLikedStationsIds() ?? [];
      final response = await networkDataSource.getLikedStations(ids);

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
      final result = await localDataSource.toggleLikeStation(id);
      return Either.right(result);
    } catch (e) {
      return Either.left(CacheFailure(e.toString()));
    }
  }
}
