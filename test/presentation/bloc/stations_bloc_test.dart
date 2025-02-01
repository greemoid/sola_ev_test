import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sola_ev_test/core/failure.dart';
import 'package:sola_ev_test/domain/repositories/istations_repository.dart';
import 'package:sola_ev_test/presentation/bloc/stations_bloc.dart';

import '../utils/mock_stations_repository.dart';
import '../utils/station_list_mock.dart';
import '../utils/station_mock.dart';

void main() {
  late IStationsRepository stationsRepository;

  setUp(() {
    stationsRepository = MockStationsRepository();
    registerFallbackValue('station-000');
  });

  group('StationsBloc', () {
    blocTest<StationsBloc, StationsState>(
      'GetAllStationsEvent should emit stationsListMock',
      build: () {
        when(() => stationsRepository.getAllStations()).thenAnswer(
          (_) async => Right(stationListMock),
        );
        return StationsBloc(stationsRepository: stationsRepository);
      },
      act: (bloc) => bloc.add(GetAllStationsEvent()),
      expect: () => [
        StationsLoading(),
        StationsLoaded(stations: stationListMock),
      ],
    );

    blocTest<StationsBloc, StationsState>(
      'GetAllStationsEvent should emit StationsError',
      build: () {
        when(() => stationsRepository.getAllStations()).thenAnswer(
          (_) async => Left(ServerFailure('Failed to fetch stations')),
        );
        return StationsBloc(stationsRepository: stationsRepository);
      },
      act: (bloc) => bloc.add(GetAllStationsEvent()),
      expect: () => [
        StationsLoading(),
        StationsError(errorMessage: 'Failed to fetch stations'),
      ],
    );

    blocTest('GetStationByIdEvent should emit a station',
        build: () {
          when(() => stationsRepository.getStationById('station-001'))
              .thenAnswer(
            (_) async => Right(stationMock),
          );
          return StationsBloc(stationsRepository: stationsRepository);
        },
        act: (bloc) => bloc.add(GetStationByIdEvent(id: 'station-001')),
        expect: () => [
              StationsLoading(),
              StationByIdLoaded(station: stationMock),
            ]);

    blocTest(
      'GetStationByIdEvent should return a station',
      build: () {
        when(() => stationsRepository.getStationById(any())).thenAnswer(
          (_) async => Left(ServerFailure('There no such station')),
        );
        return StationsBloc(stationsRepository: stationsRepository);
      },
      act: (bloc) => bloc.add(GetStationByIdEvent(id: 'station-000')),
      expect: () => [
        StationsLoading(),
        StationsError(errorMessage: 'There no such station'),
      ],
    );
  });
}
