import 'dart:async';

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
  bool isLoading = false;
  List<dynamic> stations = [];
  Timer _dormant;
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
    if (_dormant != null) {
      _dormant.cancel();
      _dormant = null;
    }
    isLoading = true;
    selectedStation = val;
    notifyListeners();
    final dynamic data = await HttpService.getStream(val.id ?? '2345');
    if (data is String && data.length > 0) {
      player.play(data);
      isPlaying = true;
      MediaNotification.showNotification(title: val.name, author: val.genre, isPlaying: true);
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      return;
    }
  }

  void pause([bool clearNotif = false]) async {
    player.pause();
    isPlaying = false;
    MediaNotification.showNotification(title: selectedStation.name, author: selectedStation.genre, isPlaying: false);
    notifyListeners();
    _dormant = Timer(Duration(seconds: clearNotif ? 0 : 10), () {
      selectedStation = null;
      MediaNotification.hideNotification();
      notifyListeners();
    });
  }

  void stop() {
    player.stop();
    isPlaying = false;
    selectedStation = null;
    MediaNotification.hideNotification();
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

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }
}
