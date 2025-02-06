import 'package:sola_ev_test/domain/entities/connector.dart';
import 'package:sola_ev_test/domain/entities/coordinates.dart';
import 'package:sola_ev_test/domain/entities/station.dart';

final stationMock = Station(
  id: 'station-001',
  title: 'ECO Charge Hub',
  address: 'вул. Хрещатик, 22, Київ, 01001',
  price: 0.24,
  coordinates: Coordinates(latitude: 50.447166, longitude: 30.522731),
  isPublic: true,
  connectors: [
    Connector(id: 'connector-001', type: 'CCS', maxPower: 150),
    Connector(id: 'connector-002', type: 'CHAdeMO', maxPower: 100)
  ],
  imageUrl:
      'https://images.pexels.com/photos/29653407/pexels-photo-29653407/free-photo-of-electric-vehicle-charging-station-at-flying-j.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  isFavorite: false,
);
