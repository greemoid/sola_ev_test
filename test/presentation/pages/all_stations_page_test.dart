import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sola_ev_test/presentation/bloc/stations_bloc.dart';
import 'package:sola_ev_test/presentation/pages/all_stations_page.dart';

import '../utils/station_list_mock.dart';
import '../utils/stations_bloc_mock.dart';

void main() {
  late StationsBloc stationsBloc;

  setUp(() {
    stationsBloc = StationsBlocMock();
  });

  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: BlocProvider.value(
        value: stationsBloc,
        child: child,
      ),
    );
  }

  testWidgets('should show loading indicator first', (tester) async {
    whenListen(
      stationsBloc,
      Stream.fromIterable([StationsLoading()]),
      initialState: StationsInitial(),
    );

    await tester.pumpWidget(buildTestWidget(AllStationsPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(Text), findsNothing);
  });

  testWidgets('should show station list when state is StationsLoaded',
      (tester) async {
    whenListen(
      stationsBloc,
      Stream.fromIterable([StationsLoaded(stations: stationListMock)]),
      initialState: StationsInitial(),
    );

    await tester.pumpWidget(buildTestWidget(AllStationsPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('ECO Charge Hub'), findsOneWidget);
    expect(find.text('2 ECO Charge Hub'), findsOneWidget);
  });

  testWidgets('should show error when state is StationsError', (tester) async {
    whenListen(
      stationsBloc,
      Stream.fromIterable([StationsError(errorMessage: 'Error occurred')]),
      initialState: StationsInitial(),
    );

    await tester.pumpWidget(buildTestWidget(AllStationsPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);

    expect(find.text('ECO Charge Hub'), findsNothing);
    expect(find.text('2 ECO Charge Hub'), findsNothing);

    expect(find.text('Error occurred'), findsOneWidget);
  });

  /**
   * Can't run this test anymore because using AutoRouterObserver on this page
   */
  /* testWidgets('should emit GetAllStationsEvent on initState()', (tester) async {
    whenListen(
      stationsBloc,
      Stream.fromIterable([StationsLoading()]),
      initialState: StationsInitial(),
    );

    await tester.pumpWidget(buildTestWidget(AllStationsPage()));
    await tester.pump();

    verify(() => stationsBloc.add(GetAllStationsEvent())).called(1);
  });*/

  testWidgets('should transition from loading to loaded', (tester) async {
    final streamController = StreamController<StationsState>();

    whenListen(
      stationsBloc,
      streamController.stream,
      initialState: StationsInitial(),
    );

    await tester.pumpWidget(buildTestWidget(AllStationsPage()));

    streamController.add(StationsLoading());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(Text), findsNothing);

    streamController.add(StationsLoaded(stations: stationListMock));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('ECO Charge Hub'), findsOneWidget);
  });

  testWidgets('should transition from loading to error', (tester) async {
    final streamController = StreamController<StationsState>();

    whenListen(
      stationsBloc,
      streamController.stream,
      initialState: StationsInitial(),
    );

    await tester.pumpWidget(buildTestWidget(AllStationsPage()));

    streamController.add(StationsLoading());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(Text), findsNothing);

    streamController.add(StationsError(errorMessage: 'Error occurred'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);

    expect(find.text('ECO Charge Hub'), findsNothing);
    expect(find.text('2 ECO Charge Hub'), findsNothing);

    expect(find.text('Error occurred'), findsOneWidget);
  });
}
