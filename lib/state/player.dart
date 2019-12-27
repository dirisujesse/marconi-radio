import 'package:flutter/material.dart';
import 'package:marconi_radio/services/http.dart';
import 'package:marconi_radio/services/channels.dart';
import 'package:flutter/foundation.dart';
import 'package:marconi_radio/models/station.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';

class PlayerState extends ChangeNotifier {
  NativeCaller player = NativeCaller.getInstance();
  Station selectedStation;
  bool isPlaying = false;
  List<dynamic> stations = [];
  static PlayerState instance;

  PlayerState() {
    MediaNotification.setListener('pause', () {
      pause();
    });

    MediaNotification.setListener('play', () {
      play(val: selectedStation);
    });

    MediaNotification.setListener('next', () {
      playNext(val: selectedStation);
    });

    MediaNotification.setListener('prev', () {
      playPrev(val: selectedStation);
    });

    // MediaNotification.setListener('select', () {});
  }

  static PlayerState getInstance() {
    if (instance == null) {
      instance = PlayerState();
    }
    return instance;
  }

  void play({Station val}) async {
    if (selectedStation != null) {
      player.stop();
      isPlaying = false;
      notifyListeners();
    }
    selectedStation = val;
    notifyListeners();
    final dynamic data = await HttpService.getStream(val.id ?? '2345');
    if (data is String && data.length > 0) {
      player.play(data);
      isPlaying = true;
      MediaNotification.showNotification(title: val.name, author: val.genre);
      notifyListeners();
    } else {
      return;
    }
  }

  void pause({Station val}) async {
    player.pause();
    isPlaying = false;
    notifyListeners();
  }

  playPrev({Station val}) {
    final List<dynamic> stationList = stations ?? [];
    if (stationList.length > 0) {
      final idx = stationList.indexWhere(
        (it) => it["id"] == val.id,
      );
      if (idx != -1) {
        play(
          val: Station.fromJson(
            stationList[idx == 0 ? stationList.length - 1 : idx - 1],
          ),
        );
      } else {
        play(
          val: Station.fromJson(
            stationList[0],
          ),
        );
      }
    }
  }

  playNext({Station val}) {
    final List<dynamic> stationList = stations ?? [];
    if (stationList.length > 0) {
      final idx = stationList.indexWhere(
        (it) => it["id"] == val.id,
      );
      if (idx != -1) {
        play(
          val: Station.fromJson(
            stationList[idx == stationList.length - 1 ? 0 : idx + 1],
          ),
        );
      } else {
        play(
          val: Station.fromJson(
            stationList[0],
          ),
        );
      }
    }
  }
}
