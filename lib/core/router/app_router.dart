import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sola_ev_test/main.dart';
import 'package:sola_ev_test/presentation/pages/all_stations_page.dart';
import 'package:sola_ev_test/presentation/pages/station_details_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: MyHomeRoute.page,
          initial: true,
          children: [
            AutoRoute(
              path: 'all_stations',
              page: AllStationsRoute.page,
            ),
          ],
        ),
    AutoRoute(
      path: '/details',
      page: StationDetailsRoute.page,
    ),
      ];
}
