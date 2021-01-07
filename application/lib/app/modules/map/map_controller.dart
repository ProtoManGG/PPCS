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
        final CircleId circleId = CircleId(hotspotList.coronaHotspot.indexOf(element).toString());
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
        final CircleId circleId = CircleId(hotspotList.crowdHotspot.indexOf(element).toString());
        circleList[circleId] = Circle(
          circleId: circleId,
          center: LatLng(
            element.lat,
            element.long,
          ),
          radius: 40,
          fillColor: Colors.black.withOpacity(0.5),
          strokeColor: Colors.black45.withOpacity(0.2),
        );
      }
      currentState.value = AppState.loaded;
    }
  }
}
