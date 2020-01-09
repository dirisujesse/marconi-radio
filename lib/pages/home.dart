import 'package:flutter/material.dart';
import 'package:marconi_radio/components/layout/app_scaffold.dart';
import 'package:marconi_radio/components/layout/category_section.dart';
import 'package:marconi_radio/components/layout/player.dart';
import 'package:marconi_radio/components/typography/app_header.dart';
import 'package:marconi_radio/models/categories.dart';
import 'package:marconi_radio/services/channels.dart';
import 'package:marconi_radio/services/storage.dart';
import 'package:marconi_radio/styles/colors.dart';

Future<bool> _popHandler(context) async {
  bool hasRatedApp = await StorageService.getItem(key: "hasRated");
  int nextRateDay = await StorageService.getItem(key: "rateDay");
  int curMillis = DateTime.now().millisecondsSinceEpoch;
  int tenDaysMillis =
      DateTime.now().add(Duration(days: 10)).millisecondsSinceEpoch;
  if ((hasRatedApp == null || hasRatedApp == false) &&
      (nextRateDay == null || curMillis > nextRateDay ?? 0)) {
    await showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: Text("Rate Marconi Radio"),
        content: Text(
            "If you have enjoyed using Marconi Radio please consider rating it"),
        actions: <Widget>[
          FlatButton(
            textColor: appBlack,
            child: Text("Remind me later"),
            onPressed: () async {
              await StorageService.setItem(key: "hasRated", val: false);
              await StorageService.setItem(key: "rateDay", val: tenDaysMillis);
              Navigator.of(context).pop();
            },
          ),
          RaisedButton(
            child: Text("Rate Now"),
            color: appBlack,
            onPressed: () async {
              NativeCaller.instance.rate();
              await StorageService.setItem(key: "hasRated", val: true);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    return Future.value(false);
  } else {
    return Future.value(true);
  }
}

class HomePage extends StatelessWidget {
  const HomePage();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _popHandler(context),
      child: AppScaffold(
        bottomNavigationBar: MarconiPlayer(),
        appBar: AppBar(
          backgroundColor: appBlack,
          centerTitle: true,
          title: HeaderText(
            "Marconi Radio",
            color: appWhite,
            alignment: TextAlign.center,
          ),
          elevation: 1,
        ),
        body: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppSection(
                  name: "Genres",
                  data: genres,
                ),
                SizedBox(
                  height: 30,
                ),
                AppSection(
                  name: "Decades",
                  data: decades,
                ),
                SizedBox(
                  height: 30,
                ),
                AppSection(
                  name: "Countries",
                  data: countries,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
