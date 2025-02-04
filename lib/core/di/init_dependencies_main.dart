part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator
    ..registerFactory<INetworkDataSource>(
        () => NetworkDataSource(assetBundle: rootBundle))
    ..registerFactory<ILocalDataSource>(
        () => LocalDataSource(sharedPreferences: sharedPreferences))
    ..registerFactory<IStationsRepository>(
      () => StationsRepository(
        networkDataSource: serviceLocator(),
        localDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<StationsBloc>(
      () => StationsBloc(
        stationsRepository: serviceLocator(),
      ),
    );
}
