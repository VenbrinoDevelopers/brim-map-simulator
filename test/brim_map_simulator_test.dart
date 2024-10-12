import 'package:brim_map_simulator/brim_map_simulator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockPolyLineFinder extends Mock implements PolyLineFinder {
  @override
  Future<List<LatLng>?> getRoutes(
      {RoutesRequest? routeRequest, String? googleApiKey}) {
    return Future.value(
        [LatLng(6.4483, 3.5547), LatLng(6.5, 3.5), LatLng(6.5708, 3.3484)]);
  }

  @override
  String toString() {
    return 'MockPolyLineFinder';
  }
}

class FakeRouteRequest extends Fake implements RoutesRequest {}

void main() {
  group('BrimMapSimulator Tests', () {
    late BrimMapSimulator simulator;
    late MockPolyLineFinder mockPolyLineFinder;
    late LatLng pickup;
    late LatLng dropOff;

    setUp(() {
      mockPolyLineFinder = MockPolyLineFinder();

      simulator = BrimMapSimulator(
        updateInterval: Duration(milliseconds: 100),
        polyLineFinder: mockPolyLineFinder,
      );
      pickup = LatLng(6.4483, 3.5547);
      dropOff = LatLng(6.5708, 3.3484);

      print('SetUp first');
    });

    tearDown(() {
      simulator.dispose();
    });

    test('startSimulation fetches route and notifies listeners', () async {
      bool listenerCalled = false;
      simulator.onLocationChanged((LatLng latLng) {
        listenerCalled = true;
      });

      await simulator.startSimulation('mock_google_api_key',
          pickup: pickup, dropOff: dropOff);

      await Future.delayed(Duration(milliseconds: 300));

      expect(listenerCalled, isTrue);
    });
  });
}
