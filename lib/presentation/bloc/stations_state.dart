part of 'stations_bloc.dart';

@immutable
sealed class StationsState extends Equatable {}

final class StationsInitial extends StationsState {
  @override
  List<Object?> get props => [];
}

final class StationsLoaded extends StationsState {
  StationsLoaded({required this.stations});

  final List<Station> stations;

  @override
  List<Object> get props => [stations];
}

final class StationByIdLoaded extends StationsState {
  StationByIdLoaded({required this.station});

  final Station station;

  @override
  List<Object> get props => [station];
}

final class StationsError extends StationsState {
  StationsError({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

final class StationsLoading extends StationsState {
  @override
  List<Object> get props => [];
}
