import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marconi_radio/components/animations/disk.dart';
import 'package:marconi_radio/components/layout/app_scaffold.dart';
import 'package:marconi_radio/components/layout/player.dart';
import 'package:marconi_radio/components/typography/app_txt.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/styles/colors.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage();

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  double _y;
  double _x;

  @override
  Widget build(BuildContext context) {
    _y = MediaQuery.of(context).size.height;
    _x = MediaQuery.of(context).size.width;
    return Consumer<PlayerState>(builder: (context, PlayerState val, _) {
      return AppScaffold(
        bottomNavigationBar: MarconiPlayer(context, playerType: PlayerType.FloatingPlayer,),
        appBar: AppBar(
          backgroundColor: appBlack,
          automaticallyImplyLeading: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BodyText(
                val?.selectedStation?.name ?? " ",
                color: appWhite,
                fontWeight: FontWeight.bold,
                maxLines: 1,
              ),
              BodyText(
                val?.selectedStation?.genre ?? "" ?? " ",
                color: appWhite,
                fontSize: 12,
                maxLines: 1,
              ),
            ],
          ),
          actions: <Widget>[
            ValueListenableBuilder(
              valueListenable: Hive.lazyBox("favourites").listenable(),
              builder: (context, LazyBox box, _) {
                return FutureBuilder(
                  future: box.get(val.selectedStation.id),
                  initialData: null,
                  builder: (context, AsyncSnapshot<dynamic> data) {
                    if (data.hasData && data.data != null) {
                      return IconButton(
                        icon: Icon(Icons.favorite),
                        onPressed: () async {
                          await box.delete(val.selectedStation.id);
                        },
                      );
                    }
                    return IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () async {
                        await box.put(val.selectedStation.id,
                            val.selectedStation.toJson());
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(maxHeight: _y, maxWidth: _x),
          child: Center(
            child: AppDisk(val.selectedStation),
          ),
        ),
      );
    });
  }
}
