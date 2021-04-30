import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../routes/app_pages.dart';
import 'map_controller.dart';

class MapView extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotspots Near You 😷"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () async {
              final GetStorage box = GetStorage();
              await box.remove("_accessToken");
              Get.offAllNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: controller.obx(
            (state) => Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      controller.locationData.latitude,
                      controller.locationData.longitude,
                    ),
                    zoom: 12,
                  ),
                  onMapCreated: (GoogleMapController gcontroller) =>
                      controller.onMapCreated(gcontroller),
                  circles: Set<Circle>.of(controller.circleList.values),
                  myLocationEnabled: true,
                  markers: {
                    if (controller.origin != null) controller.origin,
                    if (controller.destination != null) controller.destination
                  },
                  onLongPress: controller.addMarker,
                  polylines: controller.polyLines,
                ),
              ],
            ),
            onError: (error) => Column(
              children: [
                IconButton(
                  onPressed: controller.onInit,
                  icon: const Icon(Icons.refresh),
                ),
                Text(error),
              ],
            ),
            onLoading: const CircularProgressIndicator(),
            onEmpty: const Text("Initial"),
          ),
        ),
      ),
    );
  }
}
