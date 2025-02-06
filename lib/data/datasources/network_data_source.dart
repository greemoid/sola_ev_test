import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sola_ev_test/data/datasources/inetwork_data_source.dart';
import 'package:sola_ev_test/data/models/station_model.dart';

import '../../core/utils.dart';

class NetworkDataSource implements INetworkDataSource {
  final AssetBundle assetBundle;

  NetworkDataSource({required this.assetBundle});

  @override
  Future<List<StationModel>> getAllStations() async {
    final jsonString = await assetBundle.loadString(assetsPath);
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => StationModel.fromJson(json)).toList();
  }

  // This function is not neccessary, but it is here to show how would I do in
  // the real project with real API that allows get one item by id
  @override
  Future<StationModel?> getStationById(String id) async {
    final jsonString = await assetBundle.loadString(assetsPath);
    final List<dynamic> jsonList = json.decode(jsonString);
    final stationJson = jsonList.firstWhere((station) => station['id'] == id,
        orElse: () => null);
    if (stationJson == null) {
      return null;
    }
    return StationModel.fromJson(stationJson);
  }

  @override
  Future<List<StationModel>?> getLikedStations(List<String> likedIds) async {
    final jsonString = await assetBundle.loadString(assetsPath);
    final List<dynamic> jsonList = json.decode(jsonString);
    final stationsList =
        jsonList.where((station) => likedIds.contains(station['id'])).toList();
    return stationsList.map((json) => StationModel.fromJson(json)).toList();
  }
}
