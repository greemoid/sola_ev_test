import 'dart:math';

import 'package:sola_ev_test/domain/entities/connector.dart';

num? findMaxPower(List<Connector> connectors) {
  return connectors.map((c) => c.maxPower ?? 0).reduce((a, b) => max(a, b));
}
