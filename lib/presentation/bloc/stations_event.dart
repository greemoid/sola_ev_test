part of 'stations_bloc.dart';

@immutable
sealed class StationsEvent extends Equatable {}

final class GetAllStationsEvent extends StationsEvent {
  @override
  List<Object> get props => [];
}

final class GetLikedStationsEvent extends StationsEvent {
  @override
  List<Object> get props => [];
}

final class GetStationByIdEvent extends StationsEvent {
  GetStationByIdEvent({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}

final class ToggleLikeStationEvent extends StationsEvent {
  ToggleLikeStationEvent({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
