abstract interface class ILocalDataSource {
  Future<bool> toggleLikeStation(String id);

  List<String>? getLikedStationsIds();
}
