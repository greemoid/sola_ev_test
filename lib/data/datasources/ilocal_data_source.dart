abstract interface class ILocalDataSource {
  Future<void> toggleLikeStation(String id);

  Future<List<String>> getLikedStations();
}
