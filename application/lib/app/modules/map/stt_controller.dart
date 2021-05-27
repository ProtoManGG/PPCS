import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../data/repository/repository.dart';

class SttController extends GetxController {
  final Repository repository;

  final isListening = false.obs;
  final speechText = 'Press the mic button and start speaking'.obs;

  SpeechToText speechToText;

  SttController(this.repository);

  @override
  void onInit() {
    super.onInit();
    speechToText = SpeechToText();
  }

  Future<void> listen({
    @required LocationData origin,
    @required String accessToken,
  }) async {
    if (!isListening.value) {
      final bool available = await speechToText.initialize(
        onStatus: (status) {
          debugPrint(status);
          if (status == 'notListening') {
            isListening.value = false;
            debugPrint(speechText.value);
            searchRoute(
              route: speechText.value,
              origin: origin,
              accessToken: accessToken,
            );
            speechToText.stop();
          }
        },
        onError: (errorNotification) {
          debugPrint("error $errorNotification");
          isListening.value = false;
          speechToText.stop();
          speechText.value = "";
        },
      );
      if (available) {
        isListening.value = true;
        speechToText.listen(
          onResult: (result) => speechText.value = result.recognizedWords,
        );
      } else {
        isListening.value = false;
        speechToText.stop();
        debugPrint(speechText.value);
        speechText.value = "";
      }
    } else {
      speechToText.cancel();
      debugPrint(speechText.value);
      isListening.value = false;
    }
  }

  @override
  void onClose() {
    speechToText.cancel();
  }

  Future<void> searchRoute({
    @required String route,
    @required LocationData origin,
    @required String accessToken,
  }) async {
    await repository.searchRoute(
      route: route,
      origin: origin,
      accessToken: accessToken,
    );
  }
}
