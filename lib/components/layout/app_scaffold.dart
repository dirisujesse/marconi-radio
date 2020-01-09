import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marconi_radio/state/network.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/styles/colors.dart';
import 'package:provider/provider.dart';

class AppScaffold extends StatelessWidget {
  final Widget bottomNavigationBar;
  final AppBar appBar;
  final Widget body;

  AppScaffold({@required this.body, this.appBar, this.bottomNavigationBar})
      : assert(body != null);

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkState>(
      builder: (context, val, child) {
        return Scaffold(
          backgroundColor: appLightGrey,
          bottomNavigationBar: bottomNavigationBar,
          appBar: appBar,
          body: Builder(
            builder: (context) {
              Timer(
                Duration(seconds: 1),
                () {
                  if (val.isOffline != null) {
                    if (val.isOffline) {
                      if (PlayerState.instance.isPlaying) {
                        PlayerState.instance.pause();
                      }
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                              "You have lost your internet connection, restore your connection to enjoy all app functionality"),
                          backgroundColor: appBlack,
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }
                  }
                },
              );
              return body;
            },
          ),
        );
      },
    );
  }
}
