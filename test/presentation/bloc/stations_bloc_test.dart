import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sola_ev_test/domain/repositories/istations_repository.dart';
import 'package:sola_ev_test/presentation/bloc/stations_bloc.dart';

import '../utils/mock_stations_repository.dart';
import '../utils/station_list_mock.dart';

void main() {
  late IStationsRepository stationsRepository;

  setUp(() {
    stationsRepository = MockStationsRepository();
  });

  blocTest<StationsBloc, StationsState>(
    'GetAllStationsEvent should return stationsListMock',
    build: () => StationsBloc(stationsRepository: stationsRepository),
    act: (bloc) => bloc.add(GetAllStationsEvent()),
    expect: () => [
      StationsLoading(),
      StationsLoaded(stations: stationListMock),
    ],
  );
}
