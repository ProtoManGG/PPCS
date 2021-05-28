import 'package:getx_ecosystem_trial/app/data/models/failure_model.dart';
import 'package:location/location.dart';

Future<LocationData> sendLocationData() async {
  final Location location = Location();

  bool? _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      throw Failure("Location Services not enabled");
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      throw Failure("Permission not granted");
    }
  }
  return location.getLocation();
}
