import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class NetworkState extends ChangeNotifier {
  static NetworkState instance;
  StreamSubscription<ConnectivityResult> connStream;
  bool isOffline;

  NetworkState() {
    connStream = Connectivity().onConnectivityChanged.listen((res) {
      switch (res) {
        case ConnectivityResult.none:
          isOffline = true;
          notifyListeners();
          break;
        default:
          isOffline = false;
          notifyListeners();
      }
    });
  }

  static NetworkState getInstance() {
    if (instance == null) {
      instance = NetworkState();
    }
    return instance;
  }

  @override
  void dispose() {
    connStream.cancel();
    super.dispose();
  }
}
