import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sola_ev_test/core/export.dart';
import 'package:sola_ev_test/data/datasources/inetwork_data_source.dart';
import 'package:sola_ev_test/data/repositories/stations_repository.dart';
import 'package:sola_ev_test/domain/entities/station.dart';
import 'package:sola_ev_test/domain/repositories/istations_repository.dart';

import '../utils/mock_network_data_source.dart';
import '../utils/station_model_list_mock.dart';
import '../utils/station_model_mock.dart';

void main() {
  late INetworkDataSource networkDataSource;
  late IStationsRepository repository;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    networkDataSource = MockNetworkDataSource();
    repository = StationsRepository(networkDataSource: networkDataSource);
  });

  test('getAllStations should return a list of Station', () async {
    when(() => networkDataSource.getAllStations())
        .thenAnswer((_) async => stationModelListMock);

    final result = await repository.getAllStations();

    expect(result, isA<Right<Failure, List<Station>>>());
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
}
