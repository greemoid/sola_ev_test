import 'package:equatable/equatable.dart';

class Connector extends Equatable {
  final String? id;
  final String? type;
  final num? maxPower;

  const Connector(
      {required this.id, required this.type, required this.maxPower});

  @override
  List<Object?> get props => [id, type, maxPower];

  Connector copyWith({
    String? id,
    String? type,
    num? maxPower,
  }) {
    return Connector(
      id: id ?? this.id,
      type: type ?? this.type,
      maxPower: maxPower ?? this.maxPower,
    );
  }
}
