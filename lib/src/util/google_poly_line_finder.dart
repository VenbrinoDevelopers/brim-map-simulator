import 'dart:convert';
import 'dart:io';

import 'package:brim_map_simulator/src/model/brim_lat_lng.dart';
import 'package:brim_map_simulator/src/model/polyline_finder.dart';
import 'package:brim_map_simulator/src/model/route_headers.dart';
import 'package:brim_map_simulator/src/model/route_request.dart';
import 'package:brim_map_simulator/src/model/route_response.dart';

/// A class that implements the PolyLineFinder interface to fetch routes
/// using the Google Maps Directions API.
class GooglePolyLineFinder extends PolyLineFinder {
  /// The API endpoint for Google Maps Directions API.
  static const String _routeApi =
      'https://routes.googleapis.com/directions/v2:computeRoutes';

  /// Retrieves routes using the Google Maps Directions API and an internal
  /// HTTP client from [dart:io].
  ///
  /// [routeRequest] contains the necessary information for the route calculation.
  /// [googleApiKey] is required to authenticate the request to the API.
  /// Returns a list of LatLng points representing the route, or null if there was an error.
  @override
  Future<List<BrimLatLng>?> getRoutes({
    RoutesRequest? routeRequest,
    String? googleApiKey,
  }) async {
    if (routeRequest == null) {
      return null;
    }

    if (googleApiKey == null || googleApiKey.isEmpty) {
      return null;
    }

    try {
      final uri = Uri.parse(_routeApi);
      final httpClient = HttpClient();

      final request = await httpClient.postUrl(uri);

      final routeHeaders = RouteHeaders.routes(googleApiKey);

      routeHeaders.toHeaders().forEach((key, value) {
        request.headers.set(key, value);
      });

      request.headers.contentType = ContentType.json;

      request.write(jsonEncode(routeRequest.toJson()));

      final response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();

        return RouteResponse.fromJson(jsonDecode(responseBody))
            .routes!
            .first
            .polyline
            ?.polyLines;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Returns a string representation of the GooglePolyLineFinder class.
  @override
  String toString() {
    return 'GooglePolyLineFinder';
  }
}
