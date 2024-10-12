import 'package:brim_map_simulator/brim_map_simulator.dart';

/// Abstract class for finding polylines (routes).
abstract class PolyLineFinder {
  /// Retrieves a list of LatLng points representing a route based on the provided
  /// [routeRequest] and Google API key.
  ///
  /// Returns a list of LatLng points or null if an error occurs.
  Future<List<BrimLatLng>?> getRoutes({
    RoutesRequest? routeRequest,
    String? googleApiKey,
  });
}
