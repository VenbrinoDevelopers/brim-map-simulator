import 'package:brim_map_simulator/brim_map_simulator.dart';

/// Decodes an encoded path string into a sequence of BrimLatLng objects.
List<LatLng> decodePolyline(final String encodedPath) {
  int len = encodedPath.length;

  final List<LatLng> coordinates = [];
  int index = 0;
  int lat = 0;
  int lng = 0;

  while (index < len) {
    int result = 1;
    int shift = 0;
    int b;
    do {
      b = encodedPath.codeUnitAt(index++) - 63 - 1;
      result += b << shift;
      shift += 5;
    } while (b >= 0x1f);
    lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

    result = 1;
    shift = 0;
    do {
      b = encodedPath.codeUnitAt(index++) - 63 - 1;
      result += b << shift;
      shift += 5;
    } while (b >= 0x1f);
    lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

    coordinates.add(LatLng(lat * 1e-5, lng * 1e-5));
  }

  return coordinates;
}

///check if a string is empty
bool isEmpty(String? val) {
  return (val == null) || (val.trim().isEmpty);
}

///check if a string is not empty
bool isNotEmpty(String? val) {
  return !isEmpty(val);
}

///Check if any object is Empty
bool isObjectEmpty(dynamic val) {
  if (val is Map) return val.isEmpty;
  if (val is List) return val.isEmpty;

  return (val == null);
}

///Check if any object is not Empty
bool isObjectNotEmpty(dynamic val) {
  return !isObjectEmpty(val);
}
