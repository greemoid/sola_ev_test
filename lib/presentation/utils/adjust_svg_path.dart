import 'package:flutter/foundation.dart';

String adjustSvgPath(String svgPath) {
  if (kIsWeb) {
    return svgPath;
  } else {
    return 'assets/$svgPath';
  }
}
