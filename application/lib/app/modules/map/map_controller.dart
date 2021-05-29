import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_ecosystem_trial/app/data/models/corona_hotspot_model.dart';
import 'package:getx_ecosystem_trial/app/data/models/crowd_hotspot_model.dart';
import 'package:getx_ecosystem_trial/app/data/models/hotspot_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../constants/constants.dart';
import '../../data/models/failure_model.dart';
import '../../data/repository/repository.dart';
import '../../services/services.dart';
import '../../shared/info_dialog.dart';
import '../../shared/location_data_sender.dart';

class MapController extends GetxController with StateMixin {
  MapController({required this.repository});
  final Repository repository;

  String? _mapStyle;
  GoogleMapController? mapController;
  Marker? origin;
  Marker? destination;
  LocationData? locationData;
  HotspotModel? hotspotModel;
  final circleList = HashMap<CircleId, Circle>();
  final Completer<GoogleMapController> _controller = Completer();
  final List<LatLng> polyPoints = [];
  final Set<Polyline> polyLines = {};

  @override
  Future<void> onInit() async {
    rootBundle
        .loadString('assets/map_style.txt')
        .then((string) => _mapStyle = string);
    await getHotspotList();
    super.onInit();
  }

  void onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) _controller.complete(controller);
    mapController = controller;
    mapController?.setMapStyle(_mapStyle);
  }

  Future<void> getHotspotList() async {
    change("Loading", status: RxStatus.loading());
    locationData = await sendLocationData();

    try {
      final _storage = StorageService().instance;
      if (locationData?.latitude == null ||
          locationData?.longitude == null ||
          _storage.box.read<String>(storageKey) == null) {
        throw Failure("Location data is not provided");
      }
      final body = await repository.getHotSpotZones(
        latitude: locationData!.latitude!,
        longitude: locationData!.longitude!,
        accessToken: _storage.box.read<String>(storageKey)!,
      );
      hotspotModel = HotspotModel.fromJson(body as Map<String, dynamic>);
      if (hotspotModel == null) {
        throw Failure("No Hotspots received from server");
      }
      _storage.box.write(storageKey, body["access_token"]);
    } on Failure catch (f) {
      change("Failure", status: RxStatus.error(f.toString()));
    }

    if (hotspotModel!.coronaHotspot.isNotEmpty) {
      for (final CoronaHotspotModel element in hotspotModel!.coronaHotspot) {
        final circleId =
            CircleId(hotspotModel!.coronaHotspot.indexOf(element).toString());

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
              title: '🦠 Hotspot Info',
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
    }

    if (hotspotModel!.crowdHotspot.isNotEmpty) {
      for (final CrowdHotspotModel element
          in hotspotModel?.crowdHotspot ?? []) {
        final circleId =
            CircleId(hotspotModel!.crowdHotspot.indexOf(element).toString());

        circleList[circleId] = Circle(
          circleId: circleId,
          center: LatLng(element.lat, element.long),
          radius: 40,
          fillColor: Colors.black.withOpacity(0.5),
          strokeColor: Colors.black45.withOpacity(0.2),
        );
      }
    }
    change("Success", status: RxStatus.success());
  }

  Future<void> addMarker(LatLng pos) async {
    if (origin == null || (origin != null && destination != null)) {
      change("Loading", status: RxStatus.loading());

      origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
      destination = null;
      change("Success", status: RxStatus.success());
    } else {
      change("Loading", status: RxStatus.loading());

      destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );
      await getRoutes();
      change("Success", status: RxStatus.success());
    }
  }

  Future<void> getRoutes() async {
    polyLines.clear();
    polyPoints.clear();
    try {
      final _storage = StorageService().instance;
      if (origin == null ||
          destination == null ||
          _storage.box.read<String>(storageKey) == null) {
        throw Failure("Location data is not provided");
      }
      final body = await repository.getRoutes(
        origin: origin!,
        destination: destination!,
        accessToken: _storage.box.read<String>(storageKey)!,
      );
      if (body["route"] is String) {
        log(body["route"] as String);
      } else {
        for (var i = 0; i < (body["route"] as List).length; i++) {
          polyPoints.add(LatLng(
            body["route"][i][1] as double,
            body["route"][i][0] as double,
          ));
        }

        polyLines.add(
          Polyline(
            polylineId: const PolylineId("polyline"),
            points: polyPoints,
            color: Colors.blueAccent,
            width: 5,
          ),
        );

        // final Completer<GoogleMapController> _controller = Completer();
        // if (!_controller.isCompleted) _controller.complete(gcontroller);
        // mapController = await _controller.future;
        mapController?.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                body["boundingBox"]["lr"]["lat"] as double,
                body["boundingBox"]["lr"]["lng"] as double,
              ),
              northeast: LatLng(
                body["boundingBox"]["ul"]["lat"] as double,
                body["boundingBox"]["ul"]["lng"] as double,
              ),
            ),
            10,
          ),
        );
      }
      _storage.box.write(storageKey, body["access_token"]);
    } on Failure catch (f) {
      change("Failure", status: RxStatus.error(f.toString()));
    }
  }
}

class LineString {
  LineString(this.lineString);
  List<List<double>> lineString;
}
