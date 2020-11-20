import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as mobile;

// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
// import 'dart:html';

import '../../routes/app_pages.dart';
import 'map_controller.dart';

class MapView extends GetView<MapController> {
  final Completer<mobile.GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    mobile.GoogleMapController mapController;
    String _mapStyle;
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
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
        child: Obx(
          () => !controller.isLoaded.value
              ? const Center(child: CircularProgressIndicator())
              : mobile.GoogleMap(
                  initialCameraPosition: mobile.CameraPosition(
                    target: mobile.LatLng(
                      controller.locationData.latitude,
                      controller.locationData.longitude,
                    ),
                    zoom: 17,
                  ),
                  onMapCreated: (mobile.GoogleMapController controller) {
                    _controller.complete(controller);
                    mapController = controller;
                    mapController.setMapStyle(_mapStyle);
                  },
                  circles: Set<mobile.Circle>.of(controller.circleList.values),
                  myLocationEnabled: true,
                  onLongPress: (argument) {
                    controller.isLoaded.value = false;
                    controller.getHotspotList();
                  },
                ),
        ),
      ),
    );
  }
}
