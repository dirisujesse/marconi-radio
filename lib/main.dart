import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:marconi_radio/models/categories.dart';
import 'package:marconi_radio/pages/detail.dart';
import 'package:marconi_radio/pages/list.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/styles/theme.dart';
import 'package:marconi_radio/pages/home.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
      runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlayerState>.value(
      value: PlayerState.getInstance(),
      child: MaterialApp(
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
      ),
    );
  }
}
