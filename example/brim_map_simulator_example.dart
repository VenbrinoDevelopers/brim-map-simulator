import 'package:brim_map_simulator/brim_map_simulator.dart';

void main() {
  const String dummyApiKey = 'dummyApiKey';

  final pickup = LatLng(6.4483, 3.5547);
  final dropOff = LatLng(6.5708, 3.3484);

  final simulator = BrimMapSimulator(
    updateInterval: Duration(milliseconds: 500),
  );

  simulator.onLocationChanged((LatLng latLng) {
    print("Location updated: ${latLng.latitude}, ${latLng.longitude}");
  });

  simulator.startSimulation(dummyApiKey, pickup: pickup, dropOff: dropOff);
}

