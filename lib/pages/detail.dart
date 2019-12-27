import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:marconi_radio/components/animations/disk.dart';
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
  }

  @override
  void dispose() {
    super.dispose();
    _ctrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _y = MediaQuery.of(context).size.height;
    _x = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<PlayerState>(
        builder: (context, PlayerState val, _) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(maxHeight: _y, maxWidth: _x),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(val.selectedStation.logo ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_jOaO2EBV-jBMOEdkGp8NtQIY8UakejJhbGnZH7_MHy49XFgXhQ&s'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: SafeArea(
                  child: Container(
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
                              BodyText(
                                val.selectedStation.name,
                                maxLines: 2,
                                color: appWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                alignment: TextAlign.center,
                              ),
                              BodyText(
                                val.selectedStation.genre,
                                maxLines: 2,
                                color: appWhite,
                                fontSize: 10,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                child: Icon(
                                  Icons.skip_previous,
                                  color: appBlack,
                                  size: 50,
                                ),
                                onTap: () {
                                  _ctrl.stop();
                                  val.playPrev(val: val.selectedStation);
                                  _ctrl.repeat();
                                },
                              ),
                              GestureDetector(
                                child: Icon(
                                  !val.isPlaying
                                      ? Icons.play_circle_filled
                                      : Icons.pause_circle_filled,
                                  color: appBlack,
                                  size: 50,
                                ),
                                onTap: () {
                                  if (val.isPlaying) {
                                    _ctrl.stop();
                                    val.pause(val: val.selectedStation);
                                  } else {
                                    val.play(val: val.selectedStation);
                                    _ctrl.repeat();
                                  }
                                },
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.skip_next,
                                  color: appBlack,
                                  size: 50,
                                ),
                                onTap: () {
                                  _ctrl.stop();
                                  val.playNext(val: val.selectedStation);
                                  _ctrl.repeat();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
