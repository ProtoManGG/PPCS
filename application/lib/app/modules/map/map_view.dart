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
  @override
  Widget build(BuildContext context) {
    final _sttController = Get.put(
      SttController(
        Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
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
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2),
                        color: Colors.white,
                      ),
                      height: 50,
                      width: Get.width * 0.7,
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                _sttController.speechText.value.capitalize ??
                                    "Listening...",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
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
                Text(error),
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
                accessToken: await _storage.box.read(storageKey),
                origin: controller.locationData,
              );
            },
            child: Icon(
              _sttController.isListening.value ? Icons.mic : Icons.mic_none,
            ),
          ),
        ),
      ),
    );
  }
}
