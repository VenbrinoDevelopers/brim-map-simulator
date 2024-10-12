class BrimLatLng {
  const BrimLatLng(double lat, double lng)
      : lat = lat < -90.0 ? -90.0 : (90.0 < lat ? 90.0 : lat),
        lng = lng >= -180 && lng < 180
            ? lng
            : (lng + 180.0) % 360.0 - 180.0;

  final double lat;

  final double lng;

  Object toJson() {
    return <double>[lat, lng];
  }

  static BrimLatLng? fromJson(Object? json) {
    if (json == null) {
      return null;
    }
    assert(json is List && json.length == 2);
    final List<Object?> list = json as List<Object?>;
    return BrimLatLng(list[0]! as double, list[1]! as double);
  }

  @override
  bool operator ==(Object other) {
    return other is BrimLatLng && other.lat == lat && other.lng == lng;
  }

  @override
  int get hashCode => Object.hash(lat, lng);
}
