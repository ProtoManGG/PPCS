import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_ecosystem_trial/app/constants/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../routes/app_pages.dart';
import 'map_controller.dart';

class MapView extends GetView<MapController> {
  final Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    GoogleMapController mapController;
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
        // child: Obx(
        //   () => !controller.isLoaded.value
        //       ? const Center(child: CircularProgressIndicator())
        //       : GoogleMap(
        //           initialCameraPosition: CameraPosition(
        //             target: LatLng(
        //               controller.locationData.latitude,
        //               controller.locationData.longitude,
        //             ),
        //             zoom: 17,
        //           ),
        //           onMapCreated: (GoogleMapController controller) {
        //             _controller.complete(controller);
        //             mapController = controller;
        //             mapController.setMapStyle(_mapStyle);
        //           },
        //           circles: Set<Circle>.of(controller.circleList.values),
        //           myLocationEnabled: true,
        //           onLongPress: (argument) {
        //             controller.isLoaded.value = false;
        //             controller.getHotspotList();
        //           },
        //         ),
        // ),
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
                _controller.complete(controller);
                mapController = controller;
                mapController.setMapStyle(_mapStyle);
              },
              circles: Set<Circle>.of(controller.circleList.values),
              myLocationEnabled: true,
              // onLongPress: (argument) {
              //   controller.isLoaded.value = false;
              //   controller.getHotspotList();
              // },
            );
          } else {
            return Text(controller.data);
          }
        }),
      ),
    );
  }
}
