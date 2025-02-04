import 'package:shared_preferences/shared_preferences.dart';
import 'package:sola_ev_test/core/utils.dart';
import 'package:sola_ev_test/data/datasources/ilocal_data_source.dart';

class LocalDataSource implements ILocalDataSource {
  LocalDataSource({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  List<String>? getLikedStationsIds() {
    return sharedPreferences.getStringList(sharedPreferencesKey);
  }

  @override
  Future<bool> toggleLikeStation(String id) async {
    final previousIds = (getLikedStationsIds() ?? []).toSet();

    previousIds.contains(id) ? previousIds.remove(id) : previousIds.add(id);

    return await sharedPreferences.setStringList(
        sharedPreferencesKey, previousIds.toList());
  }
}
