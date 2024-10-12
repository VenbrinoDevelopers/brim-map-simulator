import 'package:brim_map_simulator/src/model/brim_lat_lng.dart';
import 'package:brim_map_simulator/src/util/helpers.dart';

class RouteResponse {
  final List<Route>? routes;
  RouteResponse({
    this.routes,
  });

  RouteResponse copyWith({
    List<Route>? routes,
  }) =>
      RouteResponse(
        routes: routes ?? this.routes,
      );

  factory RouteResponse.fromJson(Map<String, dynamic> json) => RouteResponse(
        routes: json["routes"] == null
            ? []
            : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "routes": routes == null
            ? []
            : List<dynamic>.from(routes!.map((x) => x.toJson())),
      };
}

class Route {
  final Polyline? polyline;

  Route({
    this.polyline,
  });

  Route copyWith({
    int? distanceMeters,
    String? duration,
    Polyline? polyline,
  }) =>
      Route(
        polyline: polyline ?? this.polyline,
      );

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        polyline: json["polyline"] == null
            ? null
            : Polyline.fromJson(json["polyline"]),
      );

  Map<String, dynamic> toJson() => {
        "polyline": polyline?.toJson(),
      };
}

class Polyline {
  final String? encodedPolyline;

  Polyline({
    this.encodedPolyline,
  });

  Polyline copyWith({
    String? encodedPolyline,
  }) =>
      Polyline(
        encodedPolyline: encodedPolyline ?? this.encodedPolyline,
      );

  factory Polyline.fromJson(Map<String, dynamic> json) => Polyline(
        encodedPolyline: json["encodedPolyline"],
      );

  Map<String, dynamic> toJson() => {
        "encodedPolyline": encodedPolyline,
      };

  List<LatLng>? get polyLines =>
      isEmpty(encodedPolyline) ? null : decodePolyline(encodedPolyline!);
}
