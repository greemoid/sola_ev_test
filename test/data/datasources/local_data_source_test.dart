import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sola_ev_test/core/utils.dart';
import 'package:sola_ev_test/data/datasources/ilocal_data_source.dart';
import 'package:sola_ev_test/data/datasources/local_data_source.dart';

import '../utils/mock_shared_preferences.dart';

void main() {
  late SharedPreferences mockSharedPreferences;
  late ILocalDataSource localDataSource;
  final ids = ['1', '2', '3'];

  setUpAll(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = LocalDataSource(sharedPreferences: mockSharedPreferences);
  });

  test('getLikedStationsIds should return a list', () {
    when(() => mockSharedPreferences.getStringList(sharedPreferencesKey))
        .thenReturn(ids);

    final result = localDataSource.getLikedStationsIds();

    expect(result, ids);
  });

  test('getLikedStationsIds should return null', () {
    when(() => mockSharedPreferences.getStringList(sharedPreferencesKey))
        .thenReturn(null);

    final result = localDataSource.getLikedStationsIds();

    expect(result, null);
  });

  test('toggleLikeStation should add an id if it does not exist', () async {
    when(() => mockSharedPreferences.getStringList(sharedPreferencesKey))
        .thenReturn([]);
    when(() => mockSharedPreferences.setStringList(any(), any()))
        .thenAnswer((_) async => true);

    final result = await localDataSource.toggleLikeStation('1');

    verify(() =>
            mockSharedPreferences.setStringList(sharedPreferencesKey, ['1']))
        .called(1);
    expect(result, true);
  });

  test('toggleLikeStation should add an id to existing list', () async {
    when(() => mockSharedPreferences.getStringList(sharedPreferencesKey))
        .thenReturn(['1']);
    when(() => mockSharedPreferences.setStringList(any(), any()))
        .thenAnswer((_) async => true);

    final result = await localDataSource.toggleLikeStation('2');

    verify(() => mockSharedPreferences
        .setStringList(sharedPreferencesKey, ['1', '2'])).called(1);
    expect(result, true);
  });

  test(
      'toggleLikeStation should remove an id from a list, because it was in the list before',
      () async {
    when(() => mockSharedPreferences.getStringList(sharedPreferencesKey))
        .thenReturn(['1']);
    when(() => mockSharedPreferences.setStringList(any(), any()))
        .thenAnswer((_) async => true);

    final result = await localDataSource.toggleLikeStation('1');

    verify(() => mockSharedPreferences.setStringList(sharedPreferencesKey, []))
        .called(1);
    expect(result, true);
  });
}
