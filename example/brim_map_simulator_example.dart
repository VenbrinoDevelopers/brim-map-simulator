import 'package:brim_map_simulator/brim_map_simulator.dart';

void main() {
  const String dummyApiKey = 'YOUR_GOOGLE_API_KEY';

  final pickup = BrimLatLng(6.4483, 3.5547);
  final dropOff = BrimLatLng(6.5708, 3.3484);

  final simulator = BrimMapSimulator(
    updateInterval: Duration(milliseconds: 500),
  );

  simulator.onLocationChanged((BrimLatLng latLng) {
    print("Location updated: ${latLng.lat}, ${latLng.lng}");
  });

  simulator.startSimulation(dummyApiKey, pickup: pickup, dropOff: dropOff);
}
