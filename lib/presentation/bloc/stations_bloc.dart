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
    on<StationsEvent>((event, emit) {});

    on<GetAllStationsEvent>(_getAllStations);
    on<GetStationByIdEvent>(_getStationById);
    on<GetLikedStationsEvent>(_getLikedStations);
    on<ToggleLikeStationEvent>(_toggleLike);
  }

  Future<void> _getAllStations(
      GetAllStationsEvent event, Emitter<StationsState> emit) async {
    emit(StationsLoading());

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
    emit(StationsLoading());

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

  Future<void> _getLikedStations(
      GetLikedStationsEvent event, Emitter<StationsState> emit) async {
    emit(StationsLoading());

    final result = await _stationsRepository.getLikedStations();

    result.fold(
      (failure) => emit(
        StationsError(errorMessage: failure.message),
      ),
      (stations) => emit(
        StationsLoaded(stations: stations),
      ),
    );
  }

  Future<void> _toggleLike(
      ToggleLikeStationEvent event, Emitter<StationsState> emit) async {
    await _stationsRepository.toggleLikeStation(event.id);
  }
}
