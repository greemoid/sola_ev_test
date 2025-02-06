import 'package:sola_ev_test/data/models/station_model.dart';

abstract interface class INetworkDataSource {
  Future<List<StationModel>> getAllStations();

  Future<List<StationModel>?> getLikedStations(List<String> likedIds);

  Future<StationModel?> getStationById(String id);
}
