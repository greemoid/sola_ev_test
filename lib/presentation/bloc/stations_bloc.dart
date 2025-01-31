import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sola_ev_test/domain/entities/station.dart';
import 'package:sola_ev_test/domain/repositories/istations_repository.dart';

part 'stations_event.dart';
part 'stations_state.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final IStationsRepository _stationsRepository;

  StationsBloc({required IStationsRepository stationsRepository})
      : _stationsRepository = stationsRepository,
        super(StationsInitial()) {
    on<StationsEvent>((event, emit) {
      emit(StationsLoading());
    });

    on<GetAllStationsEvent>(_getAllStations);
    on<GetStationByIdEvent>(_getStationById);
  }

  Future<void> _getAllStations(
      GetAllStationsEvent event, Emitter<StationsState> emit) async {
    final result = await _stationsRepository.getAllStations();

    result.fold(
      (failure) => emit(
        StationsError(errorMessage: failure.message),
      ),
      (stations) => emit(
        StationsLoaded(stations: stations),
      ),
    );
  }

  Future<void> _getStationById(
      GetStationByIdEvent event, Emitter<StationsState> emit) async {
    final result = await _stationsRepository.getStationById(event.id);

    result.fold(
      (failure) => emit(
        StationsError(errorMessage: failure.message),
      ),
      (station) => emit(
        StationByIdLoaded(station: station),
      ),
    );
  }
}
