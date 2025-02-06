import 'package:sola_ev_test/data/models/station_model.dart';
import 'package:sola_ev_test/domain/entities/connector.dart';
import 'package:sola_ev_test/domain/entities/coordinates.dart';
import 'package:sola_ev_test/domain/entities/station.dart';

extension StationModelMapper on StationModel {
  Station toStation(bool isFavorite) {
    final mappedCoordinates = Coordinates(
      latitude: coordinates?.latitude,
      longitude: coordinates?.longitude,
    );

    final mappedConnectors = connectors
        ?.map((connector) => Connector(
            id: connector.id,
            type: connector.type,
            maxPower: connector.maxPower))
        .toList();

    return Station(
        id: id,
        title: title,
        address: address,
        price: price?.toDouble(),
        coordinates: mappedCoordinates,
        isPublic: isPublic,
        connectors: mappedConnectors,
        imageUrl: imageUrl,
        isFavorite: isFavorite);
  }
}
