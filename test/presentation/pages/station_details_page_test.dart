import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sola_ev_test/presentation/bloc/stations_bloc.dart';
import 'package:sola_ev_test/presentation/pages/station_details_page.dart';

import '../utils/station_mock.dart';
import '../utils/stations_bloc_mock.dart';

class MockStackRouter extends Mock implements StackRouter {}

void main() {
  late StationsBloc stationsBloc;
  late StackRouter mockRouter;

  setUp(() {
    stationsBloc = StationsBlocMock();
    mockRouter = MockStackRouter();
    when(() => mockRouter.popForced()).thenAnswer((_) {});
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

    await tester.pumpWidget(
        buildTestWidget(StationDetailsPage(stationId: 'station-001')));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show station details when state is StationByIdLoaded',
      (tester) async {
    whenListen(
      stationsBloc,
      Stream.fromIterable([StationByIdLoaded(station: stationMock)]),
      initialState: StationsInitial(),
    );

    await tester.pumpWidget(
        buildTestWidget(StationDetailsPage(stationId: 'station-001')));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text(stationMock.title ?? ''), findsOneWidget);
    expect(find.text('Max power'), findsOneWidget);
    expect(find.text('Price'), findsOneWidget);
  });

  testWidgets('should show error when state is StationsError', (tester) async {
    whenListen(
      stationsBloc,
      Stream.fromIterable([StationsError(errorMessage: 'Error occurred')]),
      initialState: StationsInitial(),
    );

    await tester.pumpWidget(
        buildTestWidget(StationDetailsPage(stationId: 'station-001')));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Error occurred'), findsOneWidget);
  });

  testWidgets('should transition from loading to loaded', (tester) async {
    final streamController = StreamController<StationsState>();

    whenListen(
      stationsBloc,
      streamController.stream,
      initialState: StationsInitial(),
    );

    await tester.pumpWidget(
        buildTestWidget(StationDetailsPage(stationId: 'station-001')));

    streamController.add(StationsLoading());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    streamController.add(StationByIdLoaded(station: stationMock));
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

    await tester.pumpWidget(
        buildTestWidget(StationDetailsPage(stationId: 'station-001')));

    streamController.add(StationsLoading());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    streamController.add(StationsError(errorMessage: 'Error occurred'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);

    expect(find.text('ECO Charge Hub'), findsNothing);
    expect(find.text('2 ECO Charge Hub'), findsNothing);

    expect(find.text('Error occurred'), findsOneWidget);
  });
}
