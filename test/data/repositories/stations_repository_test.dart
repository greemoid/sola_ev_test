import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sola_ev_test/core/export.dart';
import 'package:sola_ev_test/data/datasources/ilocal_data_source.dart';
import 'package:sola_ev_test/data/datasources/inetwork_data_source.dart';
import 'package:sola_ev_test/data/repositories/stations_repository.dart';
import 'package:sola_ev_test/domain/entities/station.dart';
import 'package:sola_ev_test/domain/repositories/istations_repository.dart';

import '../utils/mock_local_data_source.dart';
import '../utils/mock_network_data_source.dart';
import '../utils/station_model_list_mock.dart';
import '../utils/station_model_mock.dart';

void main() {
  late INetworkDataSource networkDataSource;
  late ILocalDataSource localDataSource;
  late IStationsRepository repository;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    networkDataSource = MockNetworkDataSource();
    localDataSource = MockLocalDataSource();
    repository = StationsRepository(
        networkDataSource: networkDataSource, localDataSource: localDataSource);
  });

  test('getAllStations should return a list of Station', () async {
    when(() => networkDataSource.getAllStations())
        .thenAnswer((_) async => stationModelListMock);

    final result = await repository.getAllStations();

    expect(result, isA<Right<Failure, List<Station>>>());
  });

  test(
      'getAllStations should return a list of Station with 1 liked and 1 unliked',
      () async {
    when(() => localDataSource.getLikedStationsIds())
        .thenReturn(['station-002']);
    when(() => networkDataSource.getAllStations())
        .thenAnswer((_) async => stationModelListMock);

    final result = await repository.getAllStations();
    late Station firstStation;
    late Station secondStation;

    result.fold((_) => null, (r) {
      firstStation = r[0];
      secondStation = r[1];
    });

    expect(result, isA<Right<Failure, List<Station>>>());
    expect(firstStation.isFavorite, false);
    expect(secondStation.isFavorite, true);
  });

  test('getAllStations should return a ServerFailure', () async {
    when(() => networkDataSource.getAllStations())
        .thenThrow(Exception('Network error'));

    final result = await repository.getAllStations();
    var errorMessage = '';

    result.fold((failure) => errorMessage = failure.message, (_) => null);

    expect(result, isA<Left<Failure, List<Station>>>());
    expect(
        result.fold((failure) => failure, (_) => null), isA<ServerFailure>());
    expect(errorMessage, 'Exception: Network error');
  });

  test('getStationById should return a Station', () async {
    when(() => networkDataSource.getStationById('station-001'))
        .thenAnswer((_) async => stationModelMock);

    final result = await repository.getStationById('station-001');
    final station = result.fold((_) => null, (station) => station);

    expect(result, isA<Right<Failure, Station>>());
    expect(station?.id, 'station-001');
  });

  test('getStationById should return a liked Station', () async {
    when(() => localDataSource.getLikedStationsIds())
        .thenReturn(['station-001']);

    when(() => networkDataSource.getStationById('station-001'))
        .thenAnswer((_) async => stationModelMock);

    final result = await repository.getStationById('station-001');
    final station = result.fold((_) => null, (station) => station);

    expect(result, isA<Right<Failure, Station>>());
    expect(station?.id, 'station-001');
    expect(station?.isFavorite, true);
  });

  test('getStationById should return a ServerFailure', () async {
    when(() => networkDataSource.getStationById('1'))
        .thenAnswer((_) async => null);

    final result = await repository.getStationById('1');
    var errorMessage = '';

    result.fold((failure) => errorMessage = failure.message, (_) => null);

    expect(result, isA<Left<Failure, Station>>());
    expect(
        result.fold((failure) => failure, (_) => null), isA<ServerFailure>());
    expect("Can't find such station", errorMessage);
  });

  test('getLikedStations should return correct list of stations', () async {
    when(() => localDataSource.getLikedStationsIds())
        .thenReturn(['station-002']);
    when(() => networkDataSource.getLikedStations(['station-002']))
        .thenAnswer((_) async => [stationModelListMock[1]]);

    final result = await repository.getLikedStations();
    String stationId = '';
    result.fold((_) => null, (r) => stationId = r[0].id ?? '');

    expect(result, isA<Right<Failure, List<Station>>>());
    expect(stationId, 'station-002');
  });

  test('getLikedStations should throw Exception', () async {
    when(() => localDataSource.getLikedStationsIds())
        .thenThrow(Exception('Error'));

    final result = await repository.getLikedStations();
    String errorMessage = '';
    result.fold((failure) => errorMessage = failure.message, (_) => null);

    expect(result, isA<Left<Failure, List<Station>>>());
    expect(
        result.fold((failure) => failure, (_) => null), isA<ServerFailure>());
    expect(errorMessage, 'Exception: Error');
  });

  test('toggleLikeStation should save id and return true', () async {
    when(() => localDataSource.toggleLikeStation('station-001'))
        .thenAnswer((_) async => true);

    final result = await repository.toggleLikeStation('station-001');
    bool isToggled = false;
    result.fold((_) => null, (r) => isToggled = r);

    verify(() => localDataSource.toggleLikeStation('station-001')).called(1);
    expect(result, isA<Right<Failure, bool>>());
    expect(isToggled, true);
  });

  test('toggleLikeStation should throw Exception', () async {
    when(() => localDataSource.toggleLikeStation('station-001'))
        .thenThrow(Exception('Error'));

    final result = await repository.toggleLikeStation('station-001');
    String errorMessage = '';
    result.fold((failure) => errorMessage = failure.message, (_) => null);

    expect(result, isA<Left<Failure, bool>>());
    expect(result.fold((failure) => failure, (_) => null), isA<CacheFailure>());
    expect(errorMessage, 'Exception: Error');
  });
}
