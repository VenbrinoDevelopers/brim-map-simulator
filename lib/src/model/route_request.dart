import 'package:brim_map_simulator/src/model/brim_lat_lng.dart';

/// Represents a request for route information.
class RoutesRequest {
  /// The starting location for the route.
  final LocationHeading? origin;

  /// The destination location for the route.
  final LocationHeading? destination;

  /// The mode of travel (e.g., driving, walking).
  final String? travelMode;

  /// Preference for routing (e.g., fastest, shortest).
  final String? routingPreference;

  /// Indicates if alternative routes should be computed.
  final bool? computeAlternativeRoutes;

  /// Modifiers for route options (e.g., avoid tolls).
  final RouteModifiers? routeModifiers;

  /// Language code for localized route information.
  final String? languageCode;

  /// Measurement units (e.g., metric or imperial).
  final String? units;

  /// Creates a new [RoutesRequest] instance.
  RoutesRequest({
    this.origin,
    this.destination,
    this.travelMode,
    this.routingPreference,
    this.computeAlternativeRoutes,
    this.routeModifiers,
    this.languageCode,
    this.units,
  });

  /// Creates a copy of the request with optional updated fields.
  RoutesRequest copyWith({
    LocationHeading? origin,
    LocationHeading? destination,
    String? travelMode,
    String? routingPreference,
    bool? computeAlternativeRoutes,
    RouteModifiers? routeModifiers,
    String? languageCode,
    String? units,
  }) =>
      RoutesRequest(
        origin: origin ?? this.origin,
        destination: destination ?? this.destination,
        travelMode: travelMode ?? this.travelMode,
        routingPreference: routingPreference ?? this.routingPreference,
        computeAlternativeRoutes:
            computeAlternativeRoutes ?? this.computeAlternativeRoutes,
        routeModifiers: routeModifiers ?? this.routeModifiers,
        languageCode: languageCode ?? this.languageCode,
        units: units ?? this.units,
      );

  /// Creates a [RoutesRequest] instance from a JSON object.
  factory RoutesRequest.fromJson(Map<String, dynamic> json) => RoutesRequest(
        origin: json["origin"] == null
            ? null
            : LocationHeading.fromJson(json["origin"]),
        destination: json["destination"] == null
            ? null
            : LocationHeading.fromJson(json["destination"]),
        travelMode: json["travelMode"],
        routingPreference: json["routingPreference"],
        computeAlternativeRoutes: json["computeAlternativeRoutes"],
        routeModifiers: json["routeModifiers"] == null
            ? null
            : RouteModifiers.fromJson(json["routeModifiers"]),
        languageCode: json["languageCode"],
        units: json["units"],
      );

  /// Converts the request to a JSON object.
  Map<String, dynamic> toJson() => {
        "origin": origin?.toJson(),
        "destination": destination?.toJson(),
        "travelMode": travelMode,
        "routingPreference": routingPreference,
        "computeAlternativeRoutes": computeAlternativeRoutes,
        "routeModifiers": routeModifiers?.toJson(),
        "languageCode": languageCode,
        "units": units,
      };

  /// Creates a [RoutesRequest] with default values based on origin and destination.
  factory RoutesRequest.withDefaultValues({
    required BrimLatLng origin,
    required BrimLatLng destination,
  }) {
    return RoutesRequest(
      origin: LocationHeading(
        location: Location(
          latLng: LatLngRoute(
            latitude: origin.lat,
            longitude: origin.lng,
          ),
        ),
      ),
      destination: LocationHeading(
        location: Location(
          latLng: LatLngRoute(
            latitude: destination.lat,
            longitude: destination.lng,
          ),
        ),
      ),
      travelMode: "DRIVE",
      routingPreference: "TRAFFIC_AWARE",
      computeAlternativeRoutes: false,
      routeModifiers: RouteModifiers(
        avoidTolls: false,
        avoidHighways: false,
        avoidFerries: false,
      ),
      languageCode: "en-US",
      units: "IMPERIAL",
    );
  }
}

class LocationHeading {
  final Location? location;

  LocationHeading({
    this.location,
  });

  LocationHeading copyWith({
    Location? location,
  }) =>
      LocationHeading(
        location: location ?? this.location,
      );

  factory LocationHeading.fromJson(Map<String, dynamic> json) =>
      LocationHeading(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
      };
}

class Location {
  final LatLngRoute? latLng;

  Location({
    this.latLng,
  });

  Location copyWith({
    LatLngRoute? latLng,
  }) =>
      Location(
        latLng: latLng ?? this.latLng,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latLng: json["latLng"] == null
            ? null
            : LatLngRoute.fromJson(json["latLng"]),
      );

  Map<String, dynamic> toJson() => {
        "latLng": latLng?.toJson(),
      };
}

class LatLngRoute {
  final double? latitude;
  final double? longitude;

  LatLngRoute({
    this.latitude,
    this.longitude,
  });

  LatLngRoute copyWith({
    double? latitude,
    double? longitude,
  }) =>
      LatLngRoute(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory LatLngRoute.fromJson(Map<String, dynamic> json) => LatLngRoute(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class RouteModifiers {
  final bool? avoidTolls;
  final bool? avoidHighways;
  final bool? avoidFerries;

  RouteModifiers({
    this.avoidTolls,
    this.avoidHighways,
    this.avoidFerries,
  });

  RouteModifiers copyWith({
    bool? avoidTolls,
    bool? avoidHighways,
    bool? avoidFerries,
  }) =>
      RouteModifiers(
        avoidTolls: avoidTolls ?? this.avoidTolls,
        avoidHighways: avoidHighways ?? this.avoidHighways,
        avoidFerries: avoidFerries ?? this.avoidFerries,
      );

  factory RouteModifiers.fromJson(Map<String, dynamic> json) => RouteModifiers(
        avoidTolls: json["avoidTolls"],
        avoidHighways: json["avoidHighways"],
        avoidFerries: json["avoidFerries"],
      );

  Map<String, dynamic> toJson() => {
        "avoidTolls": avoidTolls,
        "avoidHighways": avoidHighways,
        "avoidFerries": avoidFerries,
      };
}
