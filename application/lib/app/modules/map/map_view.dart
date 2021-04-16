import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/constants.dart';
import '../../routes/app_pages.dart';
import 'map_controller.dart';

class MapView extends GetView<MapController> {
  final Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    GoogleMapController mapController;
    String _mapStyle;
    rootBundle.loadString('assets/map_style.txt').then((string) => _mapStyle = string);
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
          Obx(() {
            if (controller.origin.value != null && controller.destination.value != null) {
              return IconButton(
                icon: const Icon(Icons.navigation_rounded),
                onPressed: controller.getRoutes,
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Obx(() {
            if (controller.currentState.value == AppState.initial) {
              return Text(controller.data);
            } else if (controller.currentState.value == AppState.loading) {
              return const CircularProgressIndicator();
            } else if (controller.currentState.value == AppState.loaded) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    controller.locationData.latitude,
                    controller.locationData.longitude,
                  ),
                  zoom: 17,
                ),
                onMapCreated: (GoogleMapController controller) {
                  if (!_controller.isCompleted) _controller.complete(controller);
                  mapController = controller;
                  mapController.setMapStyle(_mapStyle);
                },
                circles: Set<Circle>.of(controller.circleList.values),
                myLocationEnabled: true,
                markers: {
                  if (controller.origin.value != null) controller.origin.value,
                  if (controller.destination.value != null) controller.destination.value
                },
                onLongPress: controller.addMarker,
                polylines: controller.polyLines,
              );
            } else {
              return Column(
                children: [
                  IconButton(
                      onPressed: controller.onInit, icon: const Icon(Icons.refresh)),
                  Text(controller.data),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
