part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  serviceLocator
    ..registerFactory<INetworkDataSource>(
        () => NetworkDataSource(assetBundle: rootBundle))
    ..registerFactory<IStationsRepository>(
      () => StationsRepository(
        networkDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<StationsBloc>(
      () => StationsBloc(
        stationsRepository: serviceLocator(),
      ),
    );
}
