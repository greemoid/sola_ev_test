import 'package:equatable/equatable.dart';
import 'package:sola_ev_test/domain/entities/connector.dart';
import 'package:sola_ev_test/domain/entities/coordinates.dart';

class Station extends Equatable {
  final String? id;
  final String? title;
  final String? address;
  final Coordinates? coordinates;
  final bool? isPublic;
  final List<Connector>? connectors;
  final String? imageUrl;
  final bool isFavorite;

  const Station(
      {required this.id,
      required this.title,
      required this.address,
      required this.coordinates,
      required this.isPublic,
      required this.connectors,
      required this.imageUrl,
      required this.isFavorite});

  @override
  List<Object?> get props => [
        id,
        title,
        address,
        coordinates,
        isPublic,
        connectors,
        imageUrl,
        isFavorite,
      ];

  Station copyWith({
    String? id,
    String? title,
    String? address,
    Coordinates? coordinates,
    bool? isPublic,
    List<Connector>? connectors,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Station(
      id: id ?? this.id,
      title: title ?? this.title,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      isPublic: isPublic ?? this.isPublic,
      connectors: connectors ?? this.connectors,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
