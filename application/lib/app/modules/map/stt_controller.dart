import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SttController extends GetxController {
  final isListening = false.obs;
  final speechText = 'Press the mic button and start speaking'.obs;

  SpeechToText speechToText;

  @override
  void onInit() {
    super.onInit();
    speechToText = SpeechToText();
  }

  Future<void> listen() async {
    if (!isListening.value) {
      final bool available = await speechToText.initialize(
        onStatus: (status) {
          debugPrint(status);
          if (status == 'notListening') {
            isListening.value = false;
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
        speechText.value = "";
      }
    } else {
      speechToText.cancel();
      isListening.value = false;
    }
  }

  @override
  void onClose() {
    speechToText.cancel();
  }
}
