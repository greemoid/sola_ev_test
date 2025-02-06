import 'package:sola_ev_test/data/models/station_model.dart';

final stationModelMock = StationModel(
  id: 'station-001',
  title: 'ECO Charge Hub',
  address: 'вул. Хрещатик, 22, Київ, 01001',
  price: 0.24,
  coordinates: CoordinatesModel(latitude: 50.447166, longitude: 30.522731),
  isPublic: true,
  connectors: [
    ConnectorsModel(id: 'connector-001', type: 'CCS', maxPower: 150),
    ConnectorsModel(id: 'connector-002', type: 'CHAdeMO', maxPower: 100)
  ],
  imageUrl:
  'https://images.pexels.com/photos/29653407/pexels-photo-29653407/free-photo-of-electric-vehicle-charging-station-at-flying-j.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
);