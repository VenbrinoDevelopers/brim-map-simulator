import 'dart:async';

import 'package:brim_map_simulator/brim_map_simulator.dart';
import 'package:brim_map_simulator/src/util/google_poly_line_finder.dart';

class BrimMapSimulator {
  /// The polyline finder used to retrieve routes for simulation.
  final PolyLineFinder _polyLineFinder;

  /// The interval at which the location updates will be emitted.
  final Duration _updateInterval;

  /// A timer that controls the periodic updates of the simulation.
  Timer? _timer;

  /// The current index in the route being simulated.
  int _currentIndex = 0;

  /// A list of listeners to notify of location changes.
  final List<void Function(BrimLatLng)> _listeners = [];

  /// The current route being simulated, represented as a list of LatLng points.
  List<BrimLatLng> _currentRoute = [];

  /// Creates an instance of `BrimMapSimulator`.
  ///
  /// [updateInterval] specifies the frequency of location updates (default is 1 second).
  /// [polyLineFinder] is an optional parameter to provide a specific polyline finding mechanism.
  BrimMapSimulator({
    Duration updateInterval = const Duration(seconds: 1),
    PolyLineFinder? polyLineFinder,
  })  : _updateInterval = updateInterval,
        _polyLineFinder = polyLineFinder ?? GooglePolyLineFinder();

  /// Registers a listener to be notified when the location changes.
  ///
  /// [onLocationChanged] is a callback function that receives the updated [BrimLatLng] location.
  void onLocationChanged(void Function(BrimLatLng latLng) onLocationChanged) {
    addListener(onLocationChanged);
  }

  /// Adds a listener to the list of listeners.
  ///
  /// [listener] is a callback function that will receive location updates.
  void addListener(void Function(BrimLatLng latLng) listener) {
    _listeners.add(listener);
  }

  /// Removes a listener from the list of listeners.
  ///
  /// [listener] is a callback function that will no longer receive updates.
  void removeListener(void Function(BrimLatLng latLng) listener) {
    _listeners.remove(listener);
  }

  /// Starts the simulation by fetching routes based on the provided pickup and drop-off locations.
  ///
  /// [googleApiKey] is required to access the Google Maps API.
  /// [pickup] is the starting location for the route.
  /// [dropOff] is the destination location for the route.
  Future<void> startSimulation(
    String googleApiKey, {
    required BrimLatLng pickup,
    required BrimLatLng dropOff,
  }) async {
    try {
      final routes = await _polyLineFinder.getRoutes(
        routeRequest: RoutesRequest.withDefaultValues(
            origin: pickup, destination: dropOff),
        googleApiKey: googleApiKey,
      );

      if (routes?.isNotEmpty == true) {
        final newPolylinePoints = routes;
        if (newPolylinePoints?.isNotEmpty == true) {
          _updateRoute(newPolylinePoints!);
        } else {
          _logNoRoutesFound(pickup, dropOff);
        }
      } else {
        _logNoRoutesFound(pickup, dropOff);
      }
    } catch (_) {}
  }

  /// Starts the simulation using an existing list of polyline points.
  ///
  /// [polyLine] is a list of LatLng points representing the route to be simulated.
  void startPolyLineSimulation(List<BrimLatLng> polyLine) {
    _updateRoute(polyLine);
  }

  /// Starts the periodic location updates along the current route.
  void start() {
    if (_timer != null || _currentRoute.isEmpty) return;

    _timer = Timer.periodic(_updateInterval, (timer) {
      if (_currentIndex < _currentRoute.length) {
        BrimLatLng currentPoint = _currentRoute[_currentIndex];
        _notifyListeners(currentPoint);
        _currentIndex++;
      } else {
        stop();
      }
    });
  }

  /// Stops the simulation and cancels any ongoing updates.
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  /// Cleans up resources used by the simulator.
  ///
  /// This method stops the simulation and clears the list of listeners.
  void dispose() {
    stop();
    _listeners.clear();
  }

  /// Returns `true` if the simulation is currently running; otherwise, returns `false`.
  bool get isRunning => _timer != null;

  /// Updates the current route and starts the simulation with the new route.
  ///
  /// [newRoute] is a list of LatLng points representing the new route.
  void _updateRoute(List<BrimLatLng> newRoute) {
    _currentRoute = newRoute;
    _currentIndex = 0;
    start();
  }

  /// Notifies all registered listeners with the current position.
  ///
  /// [currentPosition] is the updated LatLng location that will be sent to listeners.
  void _notifyListeners(BrimLatLng currentPosition) {
    for (var listener in _listeners) {
      listener(currentPosition);
    }
  }

  /// Logs a message indicating that no routes were found between the pickup and drop-off locations.
  ///
  /// [pickup] is the starting location.
  /// [dropOff] is the destination location.
  void _logNoRoutesFound(BrimLatLng pickup, BrimLatLng dropOff) {}
}
