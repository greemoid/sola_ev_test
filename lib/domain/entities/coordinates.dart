import 'package:equatable/equatable.dart';

class Coordinates extends Equatable {
  final num? latitude;
  final num? longitude;

  const Coordinates({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];

  Coordinates copyWith({
    num? latitude,
    num? longitude,
  }) {
    return Coordinates(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
