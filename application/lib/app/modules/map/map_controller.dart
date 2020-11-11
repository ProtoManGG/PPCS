import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'api.dart' as api;
import 'model/hotspot_model.dart';
import 'widgets/info_dialog.dart';

class MapController extends GetxController {
  LocationData locationData;
  final circleList = HashMap<CircleId, Circle>();
  RxBool isLoaded = false.obs;

  // List<CoronaHotspot> hotspotList = [];
  HotSpotModel hotspotList;

  @override
  Future<void> onInit() async {
    await getHotspotList();
    super.onInit();
  }

  Future<void> getHotspotList() async {
    locationData = await sendLocationData();

    if (!locationData.isNullOrBlank) {
      try {
        hotspotList = await api.locationSender(
          locationData.latitude,
          locationData.longitude,
        );
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }

      for (final CoronaHotspot element in hotspotList.coronaHotspot) {
        final CircleId circleId =
            CircleId(hotspotList.coronaHotspot.indexOf(element).toString());
        circleList[circleId] = Circle(
          circleId: circleId,
          center: LatLng(
            element.lat,
            element.long,
          ),
          radius: element.active / 5,
          fillColor: Colors.redAccent.withOpacity(element.death / 100),
          strokeColor: Colors.redAccent.withOpacity(0.2),
          // strokeWidth: 20,
          consumeTapEvents: true,
          onTap: () async {
            // await Geocoder.local
            //     .findAddressesFromCoordinates(
            //       Coordinates(element.lat, element.long),
            //     )
            //     .then((value) => print(value.first.locality));
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
        final CircleId circleId =
            CircleId(hotspotList.crowdHotspot.indexOf(element).toString());
        circleList[circleId] = Circle(
          circleId: circleId,
          center: LatLng(
            element.lat,
            element.long,
          ),
          radius: 40,
          fillColor: Colors.black.withOpacity(0.5),
          strokeColor: Colors.black45.withOpacity(0.2),
          // strokeWidth: 20,
        );
      }
      isLoaded.value = true;
    }
  }

  Future<LocationData> sendLocationData() async {
    final Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    return location.getLocation();
  }
}
