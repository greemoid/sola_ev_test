import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sola_ev_test/data/datasources/inetwork_data_source.dart';
import 'package:sola_ev_test/data/datasources/network_data_source.dart';
import 'package:sola_ev_test/data/models/station_model.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  late INetworkDataSource networkDataSource;
  late MockAssetBundle mockAssetBundle;

  const mockJson = '''
  [
  {
    "id": "station-001",
    "title": "ECO Charge Hub",
    "address": "вул. Хрещатик, 22, Київ, 01001",
    "price": 0.24,
    "coordinates": {
      "latitude": 50.447166,
      "longitude": 30.522731
    },
    "isPublic": true,
    "connectors": [
      {
        "id": "connector-001",
        "type": "CCS",
        "maxPower": 150
      },
      {
        "id": "connector-002",
        "type": "CHAdeMO",
        "maxPower": 100
      }
    ],
    "image_url": "https://images.pexels.com/photos/29653407/pexels-photo-29653407/free-photo-of-electric-vehicle-charging-station-at-flying-j.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  },
  {
    "id": "station-002",
    "title": "Ocean Plaza Charger",
    "address": "вул. Антоновича, 176, Київ, 03150",
    "price": 0.31,
    "coordinates": {
      "latitude": 50.4116,
      "longitude": 30.5233
    },
    "isPublic": true,
    "connectors": [
      {
        "id": "connector-003",
        "type": "Type2",
        "maxPower": 22
      }
    ],
    "image_url": "https://images.pexels.com/photos/9799701/pexels-photo-9799701.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  }
  ]
  ''';

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    networkDataSource = NetworkDataSource(assetBundle: mockAssetBundle);

    // Mock rootBundle.loadString
    when(() => mockAssetBundle.loadString('assets/stations.json'))
        .thenAnswer((_) async => mockJson);
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
