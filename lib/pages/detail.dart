import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:marconi_radio/components/animations/disk.dart';
import 'package:marconi_radio/components/layout/app_scaffold.dart';
import 'package:marconi_radio/components/layout/player.dart';
import 'package:marconi_radio/components/typography/app_header.dart';
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

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;
  double _y;
  double _x;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: Duration(seconds: 30),
      vsync: this,
    )..repeat();
    if (!PlayerState.instance.isPlaying) {
      _ctrl.stop();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _y = MediaQuery.of(context).size.height;
    _x = MediaQuery.of(context).size.width;
    return AppScaffold(
      body: Consumer<PlayerState>(
        builder: (context, PlayerState val, _) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(maxHeight: _y, maxWidth: _x),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  val?.selectedStation?.logo ??
                      'https://res.cloudinary.com/jesse-dirisu/image/upload/v1577453507/marconixl.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration:
                      new BoxDecoration(color: appBlack.withOpacity(0.5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            HeaderText(
                              val?.selectedStation?.name ?? "",
                              maxLines: 2,
                              color: appWhite,
                              fontWeight: FontWeight.bold,
                              alignment: TextAlign.center,
                            ),
                            BodyText(
                              val?.selectedStation?.genre ?? "",
                              maxLines: 2,
                              color: appWhite,
                              fontSize: 15,
                              alignment: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      AppDisk(val.selectedStation, _ctrl),
                      Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                            maxHeight: _y * 0.12, maxWidth: _x * 0.8),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: appWhite.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MarconiPlayer(
                          context,
                          playerType: PlayerType.FloatingPlayer,
                          ctrl: _ctrl,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
