import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../constants/constants.dart';
import '../../data/models/failure_model.dart';
import '../../data/models/hotspot_model.dart';
import '../../data/repository/repository.dart';
import '../../services/services.dart';
import '../../shared/info_dialog.dart';
import '../../shared/location_data_sender.dart';

class MapController extends GetxController {
  final Repository repository;
  MapController({@required this.repository});
  final currentState = AppState.initial.obs;
  String data = 'Initial';
  Rx<Marker> origin = Rx<Marker>();
  Rx<Marker> destination = Rx<Marker>();

// For holding Co-ordinates as LatLng
  final List<LatLng> polyPoints = [];

//For holding instance of Polyline
  final Set<Polyline> polyLines = {};

  LocationData locationData;
  final circleList = HashMap<CircleId, Circle>();
  HotSpotModel hotspotList;

  @override
  Future<void> onInit() async {
    await getHotspotList();
    super.onInit();
  }

  Future<void> getHotspotList() async {
    currentState.value = AppState.loading;

    locationData = await sendLocationData();

    if (!locationData.isBlank) {
      try {
        final _storage = StorageService().instance;
        final body = await repository.getHotSpotZones(
          latitude: locationData.latitude,
          longitude: locationData.longitude,
          accessToken: await _storage.box.read(storageKey),
        );
        hotspotList = HotSpotModel.fromJson(body as Map<String, dynamic>);
        _storage.box.write(storageKey, body["access_token"]);
      } on Failure catch (f) {
        data = f.toString();
        currentState.value = AppState.failure;
      }

      for (final CoronaHotspot element in hotspotList.coronaHotspot) {
        final circleId = CircleId(hotspotList.coronaHotspot.indexOf(element).toString());
        circleList[circleId] = Circle(
          circleId: circleId,
          center: LatLng(element.lat, element.long),
          radius: element.active / 5,
          fillColor: Colors.redAccent.withOpacity(element.death / 100),
          strokeColor: Colors.redAccent.withOpacity(0.2),
          // strokeWidth: 20,
          consumeTapEvents: true,
          onTap: () async {
            Get.defaultDialog(
              title: '${element.lat},${element.long}',
              content: Column(
                children: [
                  InfoDialog(
                    title: "Active",
                    imagePath: "031-medical-mask.svg",
                    hotspotInfo: element.active,
                  ),
                  InfoDialog(
                    title: "Dead",
                    imagePath: "025-No.svg",
                    hotspotInfo: element.death,
                  ),
                  InfoDialog(
                    title: "Recovered",
                    imagePath: "044-immunity.svg",
                    hotspotInfo: element.recovered,
                  ),
                ],
              ),
            );
          },
        );
      }

      for (final CrowdHotspot element in hotspotList.crowdHotspot) {
        final circleId = CircleId(hotspotList.crowdHotspot.indexOf(element).toString());
        circleList[circleId] = Circle(
          circleId: circleId,
          center: LatLng(element.lat, element.long),
          radius: 40,
          fillColor: Colors.black.withOpacity(0.5),
          strokeColor: Colors.black45.withOpacity(0.2),
        );
      }
      currentState.value = AppState.loaded;
    }
  }

  Future<void> addMarker(LatLng pos) async {
    currentState.value = AppState.loading;
    if (origin.value == null || (origin.value != null && destination.value != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin

      origin.value = Marker(
        markerId: MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
      // Reset destination
      destination.value = null;

      // Reset info
      // _info = null;
    } else {
      // Origin is already set
      // Set destination
      destination.value = Marker(
        markerId: MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );

      // Get directions
      // final directions = await DirectionsRepository()
      // .getDirections(origin: origin.position, destination: pos);
      // setState(() => _info = directions);
    }
    currentState.value = AppState.loaded;
  }

  Future<void> getRoutes() async {
    currentState.value = AppState.loading;

    try {
      final _storage = StorageService().instance;
      final body = await repository.getRoutes(
        origin: origin.value,
        destination: destination.value,
        accessToken: await _storage.box.read(storageKey),
      );
      makeRoute(testList);

      _storage.box.write(storageKey, body["access_token"]);
      currentState.value = AppState.loaded;
    } on Failure catch (f) {
      data = f.toString();
      currentState.value = AppState.failure;
    }
  }

  void makeRoute(List<List<double>> routeList) {
    final LineString ls = LineString(routeList);

    for (int i = 0; i < ls.lineString.length; i++) {
      polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
    }

    setPolyLines();
  }

  void setPolyLines() {
    final Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Colors.lightBlue,
      points: polyPoints,
      width: 20,
    );
    polyLines.add(polyline);
  }
}

class LineString {
  LineString(this.lineString);
  List<List<double>> lineString;
}

List<List<double>> testList = [
  [8.681496, 49.41461],
  [8.68149, 49.414711],
  [8.681441, 49.415655],
  [8.681436, 49.415747],
  [8.681455, 49.415835],
  [8.681509, 49.416087],
  [8.681642, 49.416498],
  [8.681671, 49.416588],
  [8.681701, 49.416684],
  [8.681875, 49.417287],
  [8.68189, 49.417394],
  [8.682107, 49.41739],
  [8.682676, 49.417387],
  [8.683597, 49.417374],
  [8.684686, 49.417376],
  [8.685025, 49.417377],
  [8.685354, 49.417372],
  [8.685707, 49.41737],
  [8.68639, 49.417365],
  [8.686801, 49.417361],
  [8.687151, 49.417359],
  [8.687469, 49.417356],
  [8.687927, 49.417355],
  [8.688813, 49.417381],
  [8.690338, 49.41743],
  [8.690866, 49.417308],
  [8.691735, 49.417102],
  [8.691957, 49.417117],
  [8.69198, 49.417121],
  [8.691941, 49.41722],
  [8.691817, 49.417369],
  [8.691427, 49.417726],
  [8.691072, 49.418051],
  [8.690968, 49.418158],
  [8.690936, 49.418188],
  [8.690939, 49.418208],
  [8.690939, 49.418296],
  [8.69092, 49.418378],
  [8.690912, 49.418411],
  [8.69067, 49.418981],
  [8.690664, 49.418992],
  [8.690614, 49.419093],
  [8.690547, 49.419174],
  [8.690479, 49.419204],
  [8.690446, 49.419218],
  [8.690275, 49.419577],
  [8.690123, 49.419833],
  [8.689854, 49.420216],
  [8.689652, 49.420514],
  [8.68963, 49.42051],
  [8.688601, 49.420393],
  [8.687872, 49.420318]
];
