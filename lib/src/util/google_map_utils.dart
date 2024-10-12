import 'dart:convert';
import 'dart:io';

import 'package:brim_map_simulator/src/model/brim_lat_lng.dart';
import 'package:brim_map_simulator/src/model/route_headers.dart';
import 'package:brim_map_simulator/src/model/route_request.dart';
import 'package:brim_map_simulator/src/model/route_response.dart';

class GooglePolyLineFinder extends PolyLineFinder {
  static const String _routeApi =
      'https://routes.googleapis.com/directions/v2:computeRoutes';

  ///Get routes using Google Maps Directions API
  ///and [dart:io] internal  client
  @override
  Future<List<LatLng>?> getRoutes({
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
      // Set headers
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
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }

  @override
  String toString() {
    return 'GooglePolyLineFinder';
  }
}

abstract class PolyLineFinder {
  Future<List<LatLng>?> getRoutes({
    RoutesRequest? routeRequest,
    String? googleApiKey,
  });
}
