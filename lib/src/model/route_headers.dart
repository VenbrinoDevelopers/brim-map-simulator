class RouteHeaders {
  final String? contentType;
  final String? xGoogApiKey;
  final String? xGoogFieldMask;

  RouteHeaders({
    this.contentType,
    this.xGoogApiKey,
    this.xGoogFieldMask,
  });

  RouteHeaders copyWith({
    String? contentType,
    String? xGoogApiKey,
    String? xGoogFieldMask,
  }) =>
      RouteHeaders(
        contentType: contentType ?? this.contentType,
        xGoogApiKey: xGoogApiKey ?? this.xGoogApiKey,
        xGoogFieldMask: xGoogFieldMask ?? this.xGoogFieldMask,
      );

  factory RouteHeaders.routes(String googleApiKey) {
    return RouteHeaders(
      contentType: 'application/json',
      xGoogApiKey: googleApiKey,
      xGoogFieldMask: 'routes.polyline.encodedPolyline,',
    );
  }

  factory RouteHeaders.fromJson(Map<String, dynamic> json) => RouteHeaders(
        contentType: json["Content-Type"],
        xGoogApiKey: json["X-Goog-Api-Key"],
        xGoogFieldMask: json["X-Goog-FieldMask"],
      );

  Map<String, dynamic> toJson() => {
        "Content-Type": contentType,
        "X-Goog-Api-Key": xGoogApiKey,
        "X-Goog-FieldMask": xGoogFieldMask,
      };

  Map<String, dynamic> toHeaders() => {
        "Content-Type": contentType,
        "X-Goog-Api-Key": xGoogApiKey,
        "X-Goog-FieldMask": xGoogFieldMask,
      };
}
