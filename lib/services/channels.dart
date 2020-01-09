import 'package:flutter/services.dart';

class NativeCaller {
  MethodChannel channel = const MethodChannel('marconi_audio_stream');
  bool isPlaying = false;
  static NativeCaller instance;

  static NativeCaller getInstance() {
    if (instance == null) {
      instance = NativeCaller();
    }
    return instance;
  }

  void play(url) async {
    try {
      await channel.invokeMethod('play', {"url": url});
      isPlaying = true;
    } on PlatformException catch (e) {
      throw "Failed to play: '${e.message}'.";
    }
  }

  void rate() async {
    try {
      await channel.invokeMethod('rate');
    } on PlatformException catch (e) {
      throw "Failed to rate: '${e.message}'.";
    }
  }

  void pause() async {
    try {
      await channel.invokeMethod('pause');
      isPlaying = false;
    } on PlatformException catch (e) {
      throw "Failed to pause: '${e.message}'.";
    }
  }

  void stop() async {
    try {
      await channel.invokeMethod('stop');
      isPlaying = false;
    } on PlatformException catch (e) {
      throw "Failed to stop: '${e.message}'.";
    }
  }
}