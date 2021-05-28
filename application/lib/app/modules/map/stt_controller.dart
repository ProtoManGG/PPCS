import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_ecosystem_trial/app/constants/storage_constants.dart';
import 'package:getx_ecosystem_trial/app/data/models/failure_model.dart';
import 'package:getx_ecosystem_trial/app/data/providers/api_client.dart';
import 'package:getx_ecosystem_trial/app/services/storage_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../data/repository/repository.dart';
import 'map_controller.dart';

class SttController extends GetxController with StateMixin {
  SttController(this.repository);

  final _mapController = Get.put(
    MapController(
      repository: Repository(
        apiClient: ApiClient(),
      ),
    ),
  );

  final Repository repository;

  final isListening = false.obs;
  final speechText = 'Press the mic button and start speaking'.obs;

  SpeechToText? speechToText;

  @override
  void onInit() {
    super.onInit();
    speechToText = SpeechToText();
  }

  Future<void> listen({
    required LocationData origin,
    required String accessToken,
  }) async {
    if (!isListening.value) {
      final bool available = await speechToText?.initialize(
            onStatus: (status) async {
              debugPrint(status);
              if (status == 'notListening') {
                isListening.value = false;
                debugPrint(speechText.value);
                await searchRoute(
                  route: speechText.value,
                  origin: origin,
                  accessToken: accessToken,
                );
                speechToText?.stop();
              }
            },
            onError: (errorNotification) {
              debugPrint("error $errorNotification");
              isListening.value = false;
              speechToText?.stop();
              speechText.value = "";
            },
          ) ??
          false;
      if (available) {
        isListening.value = true;
        speechToText?.listen(
          onResult: (result) => speechText.value = result.recognizedWords,
        );
      } else {
        isListening.value = false;
        speechToText?.stop();
        debugPrint(speechText.value);
        speechText.value = "";
      }
    } else {
      speechToText?.cancel();
      debugPrint(speechText.value);
      isListening.value = false;
    }
  }

  @override
  void onClose() {
    speechToText?.cancel();
  }

  Future<void> searchRoute({
    required String route,
    required LocationData origin,
    required String accessToken,
  }) async {
    change("Loading", status: RxStatus.loading());

    _mapController.polyLines.clear();
    _mapController.polyPoints.clear();
    try {
      final _storage = StorageService().instance;
      final body = await repository.searchRoute(
        route: route,
        origin: origin,
        accessToken: accessToken,
      );
      if (body["route"] is String) {
        log(body["route"] as String);
      } else {
        for (var i = 0; i < (body["route"] as List).length; i++) {
          _mapController.polyPoints.add(LatLng(
            body["route"][i][1] as double,
            body["route"][i][0] as double,
          ));
        }

        _mapController.polyLines.add(Polyline(
          polylineId: const PolylineId("polyline"),
          points: _mapController.polyPoints,
        ));

        // final Completer<GoogleMapController> _controller = Completer();
        // if (!_controller.isCompleted) _controller.complete(gcontroller);
        // mapController = await _controller.future;
        _mapController.mapController?.animateCamera(
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
      change("Success", status: RxStatus.success());
    } on Failure catch (f) {
      change("Failure", status: RxStatus.error(f.toString()));
    }
  }
}
