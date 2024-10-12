# 🚗 Brim Map Simulator

Brim Map Simulator is a pure Dart package designed to simulate location updates along a specified route.It provides functionality to fetch routes, update locations at defined intervals, and notify listeners of location changes.

## Features

- Fetch routes from Google Maps Directions API.
- Simulate periodic location updates along a route.
- Register listeners to respond to location changes.
- Clean resource management with disposal methods.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  brim_map_simulator: ^1.0.0 # Replace with the latest version
```

The run

#### dart pub get

or, if using Flutter

#### flutter pub get

## Usage

To use the Brim Map Simulator, follow these steps:

1. Import the package:

```dart
import 'package:brim_map_simulator/brim_map_simulator.dart';
```

2. Create an instance of BrimMapSimulator:

```dart
final simulator = BrimMapSimulator(
  updateInterval: Duration(seconds: 1),
);
```

3. Register a listener for location updates:

```dart
simulator.onLocationChanged((BrimLatLng latLng) {
  print("Location updated: ${latLng.latitude}, ${latLng.longitude}");
});
```

4. Start the simulation with pickup and drop-off locations:

Note: If you don't have a Google API key, you can use simulator.startPolyLineSimulation() and pass a default polyline. Refer to step 5 for more details.

```dart
const String googleApiKey = 'YOUR_GOOGLE_API_KEY';
final pickup = BrimLatLng(6.4483, 3.5547);
final dropOff = BrimLatLng(6.5708, 3.3484);

await simulator.startSimulation(googleApiKey, pickup: pickup, dropOff: dropOff);
```

5. you can also simulate if you have a polyline already

```dart
simulator.startPolyLineSimulation(<BrimLatLng>[]);
```

6. Stopping the simulation:

```dart
simulator.stop();
```

7. Dispose the simulator when done:

```
simulator.dispose();
```

## Example

```dart
void main() async {
  const String dummyApiKey = 'YOUR_GOOGLE_API_KEY';

  final pickup = BrimLatLng(6.4483, 3.5547);
  final dropOff = BrimLatLng(6.5708, 3.3484);

  final simulator = BrimMapSimulator(
    updateInterval: Duration(milliseconds: 500),
  );

  simulator.onLocationChanged((BrimLatLng latLng) {
    print("Location updated: ${latLng.latitude}, ${latLng.longitude}");
  });

  await simulator.startSimulation(dummyApiKey, pickup: pickup, dropOff: dropOff);

  // Optionally stop the simulation after a certain time
  Future.delayed(Duration(seconds: 10), () {
    simulator.stop();
    simulator.dispose();
  });
}
```

## Advanced

For more advanced use cases, you can customize how the polyline is fetched by implementing your own `PolyLineFinder`. This allows you to provide a custom route source for the simulator instead of relying on Google Maps.

### Custom Polyline Finder

In this example, `CustomPolyLineFinder` is implemented to return an empty polyline list, but you can modify it to fetch polylines from any source (e.g., a local file, another API, etc.).

```dart
class CustomPolyLineFinder extends PolyLineFinder {
  @override
  Future<List<LatLng>?> getRoutes(
      {RoutesRequest? routeRequest, String? googleApiKey}) async {
    /// You can get polyline from any source you feel like
    return [];
  }
}


final simulator = BrimMapSimulator(
  updateInterval: Duration(milliseconds: 500),
  polyLineFinder: CustomPolyLineFinder(),
);

```

### Contributing

If you would like to contribute to this package, please fork the repository and create a pull request. Contributions are welcome!

### License

This project is licensed under the MIT License. See the LICENSE file for details.

## Notes:

Make sure to replace 'YOUR_GOOGLE_API_KEY' with your actual Google API key in the example.
Adjust the version number in the installation section as necessary.
You can expand or modify sections based on additional features or requirements specific to your package.
