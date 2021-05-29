import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/storage_constants.dart';
import '../../data/providers/api_client.dart';
import '../../data/repository/repository.dart';
import '../../routes/app_pages.dart';
import '../../services/storage_service.dart';
import 'map_controller.dart';
import 'stt_controller.dart';

class MapView extends GetView<MapController> {
  final _sttController = Get.put(
    SttController(Repository(apiClient: ApiClient())),
  );
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
                _sttController.obx(
                  (state) => GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        controller.locationData!.latitude!,
                        controller.locationData!.longitude!,
                      ),
                      zoom: 12,
                    ),
                    onMapCreated: (GoogleMapController gcontroller) =>
                        controller.onMapCreated(gcontroller),
                    circles: Set<Circle>.of(controller.circleList.values),
                    myLocationEnabled: true,
                    markers: {
                      if (controller.origin != null) controller.origin!,
                      if (controller.destination != null)
                        controller.destination!
                    },
                    onLongPress: controller.addMarker,
                    polylines: controller.polyLines,
                  ),
                  onEmpty: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        controller.locationData!.latitude!,
                        controller.locationData!.longitude!,
                      ),
                      zoom: 12,
                    ),
                    onMapCreated: (GoogleMapController gcontroller) =>
                        controller.onMapCreated(gcontroller),
                    circles: Set<Circle>.of(controller.circleList.values),
                    myLocationEnabled: true,
                    markers: {
                      if (controller.origin != null) controller.origin!,
                      if (controller.destination != null)
                        controller.destination!
                    },
                    onLongPress: controller.addMarker,
                    polylines: controller.polyLines,
                  ),
                  onError: (error) {
                    WidgetsBinding.instance!.addPostFrameCallback(
                      (_) {
                        Get.snackbar(
                          "Oops",
                          error.toString(),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          titleText: const Text(
                            "Oh No!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          messageText: Text(
                            error.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    );
                    return GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          controller.locationData!.latitude!,
                          controller.locationData!.longitude!,
                        ),
                        zoom: 12,
                      ),
                      onMapCreated: (GoogleMapController gcontroller) =>
                          controller.onMapCreated(gcontroller),
                      circles: Set<Circle>.of(controller.circleList.values),
                      myLocationEnabled: true,
                      markers: {
                        if (controller.origin != null) controller.origin!,
                        if (controller.destination != null)
                          controller.destination!
                      },
                      onLongPress: controller.addMarker,
                      polylines: controller.polyLines,
                    );
                  },
                  onLoading: const Center(child: CircularProgressIndicator()),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 2),
                        color: Colors.white,
                      ),
                      height: 50,
                      width: Get.width * 0.7,
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => TextFormField(
                                controller:
                                    _sttController.searchController.value,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                textAlign: TextAlign.center,
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              final _storage = StorageService().instance;
                              await _sttController.searchRoute(
                                route:
                                    _sttController.searchController.value.text,
                                origin: controller.locationData!,
                                accessToken:
                                    _storage.box.read<String>(storageKey)!,
                              );
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onError: (error) => Column(
              children: [
                IconButton(
                  onPressed: controller.onInit,
                  icon: const Icon(Icons.refresh),
                ),
                Text(error!),
              ],
            ),
            onLoading: const CircularProgressIndicator(),
            onEmpty: const Text("Initial"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => AvatarGlow(
          animate: _sttController.isListening.value,
          glowColor: Colors.redAccent,
          endRadius: 90.0,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () async {
              final _storage = StorageService().instance;

              return _sttController.listen(
                accessToken: _storage.box.read<String>(storageKey)!,
                origin: controller.locationData!,
              );
            },
            child: _sttController.obx(
              (state) => Icon(
                _sttController.isListening.value ? Icons.mic : Icons.mic_none,
              ),
              onEmpty: Icon(
                _sttController.isListening.value ? Icons.mic : Icons.mic_none,
              ),
              onError: (error) => Icon(
                _sttController.isListening.value ? Icons.mic : Icons.mic_none,
                color: Colors.redAccent,
              ),
              onLoading: const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
