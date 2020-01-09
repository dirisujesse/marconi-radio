import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marconi_radio/state/network.dart';
import 'package:provider/provider.dart';

import 'package:marconi_radio/models/categories.dart';
import 'package:marconi_radio/pages/detail.dart';
import 'package:marconi_radio/pages/list.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/styles/theme.dart';
import 'package:marconi_radio/pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MarconiRadioApp());
}

class MarconiRadioApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MarconiRadioAppState();
  }
}

class _MarconiRadioAppState extends State<MarconiRadioApp>
    with WidgetsBindingObserver {
  Timer inactiveTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    PlayerState.instance.pause();
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        if (inactiveTimer != null) {
          inactiveTimer.cancel();
        }
        break;
      case AppLifecycleState.inactive:
        inactiveTimer = Timer(Duration(milliseconds: 400), () {
          if (PlayerState.instance != null) {
            if (PlayerState.instance.isPlaying) {
              PlayerState.instance.pause(true);
            }
          }
        });
        break;
      default:
        print("Null State");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerState.getInstance()),
        ChangeNotifierProvider(create: (_) => NetworkState.getInstance()),
      ],
      child: Consumer<NetworkState>(
        builder: (context, state, _) {
          return MaterialApp(
            title: 'Upright_NG',
            theme: appThemeData(),
            home: const HomePage(),
            onGenerateRoute: (RouteSettings settings) {
              final path = settings.name;
              if (path.startsWith('/list')) {
                AppCategory cat = settings.arguments;
                return MaterialPageRoute(builder: (BuildContext context) {
                  return ListPage(
                    title: cat.assetName,
                    category: cat,
                  );
                });
              } else if (path.startsWith('/detail')) {
                return MaterialPageRoute(builder: (BuildContext context) {
                  return const DetailPage();
                });
              } else {
                return MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                );
              }
            },
            onUnknownRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                builder: (BuildContext context) => HomePage(),
              );
            },
          );
        },
      ),
    );
  }
}
