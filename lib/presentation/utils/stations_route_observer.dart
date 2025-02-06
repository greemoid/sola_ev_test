import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sola_ev_test/presentation/bloc/stations_bloc.dart';

class StationsRouteObserver extends AutoRouterObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    final name = route.settings.name ?? '';
    if (name == 'StationDetailsRoute') {
      route.navigator?.context.read<StationsBloc>().add(GetAllStationsEvent());
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    final name = route.settings.name ?? '';
    if (name == 'MyHomeRoute') {
      route.navigator?.context.read<StationsBloc>().add(GetAllStationsEvent());
    }
  }
}
