import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sola_ev_test/data/datasources/inetwork_data_source.dart';
import 'package:sola_ev_test/data/datasources/network_data_source.dart';
import 'package:sola_ev_test/data/models/station_model.dart';

import '../utils/mock_asset_bundle.dart';

void main() {
  late INetworkDataSource networkDataSource;
  late MockAssetBundle mockAssetBundle;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    networkDataSource = NetworkDataSource(assetBundle: mockAssetBundle);
  });

  test('getAllStations should return a list of StationModel', () async {
    final result = await networkDataSource.getAllStations();

    expect(result, isA<List<StationModel>>());
    expect(result.length, 2);
    expect(result.first.id, 'station-001');
  });

  test('getStationById should return a StationModel', () async {
    final result = await networkDataSource.getStationById(
      'station-002',
    );

    expect(result, isA<StationModel>());
    expect(result?.id, 'station-002');
  });

  test('getLikedStations should return a list of liked StationModels',
      () async {
    final result = await networkDataSource.getLikedStations(
      ['station-001'],
    );

    expect(result, isA<List<StationModel>>());
    expect(result?.length, 1);
    expect(result?[0].id, 'station-001');
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  test('getStationById should return null if station does not exist', () async {
    // Json has only ids like "station-0XX"(where XX - number)
    final result = await networkDataSource.getStationById('999');

    expect(result, isNull);
  });

  test('getLikedStations should return only liked stations', () async {
    // Json has only ids like "station-0XX"(where XX - number)
    final result = await networkDataSource.getLikedStations(
      [
        '1',
        'station-002',
        '3',
      ],
    );

    expect(result, isA<List<StationModel>>());
    expect(result?.length, 1);
    expect(result?.first.id, 'station-002');
  });
}
