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
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Consumer<PlayerState>(
            builder: (context, PlayerState val, _) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(val.selectedStation.logo ??
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_jOaO2EBV-jBMOEdkGp8NtQIY8UakejJhbGnZH7_MHy49XFgXhQ&s'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: appBlack.withOpacity(0.5)),
                  ),
                ),
              );
            },
          ),
          Positioned.fill(
            child: Center(
              child: Consumer<PlayerState>(
                builder: (context, PlayerState val, _) {
                  return AppDisk(val.selectedStation, _ctrl);
                },
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            right: 30,
            height: 100,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: appWhite.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Consumer<PlayerState>(
                  builder: (context, PlayerState val, _) {
                    return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        color: appBlack,
                        size: 50,
                      ),
                      onPressed: () {
                        _ctrl.stop();
                        val.playPrev(val: val.selectedStation);
                        _ctrl.repeat();
                      },
                    ),
                    IconButton(
                          icon: Icon(
                            !val.isPlaying
                                ? Icons.play_circle_filled
                                : Icons.pause_circle_filled,
                            color: appBlack,
                            size: 50,
                          ),
                          onPressed: () {
                            if (val.isPlaying) {
                              _ctrl.stop();
                              val.pause(val: val.selectedStation);
                            } else {
                              val.play(val: val.selectedStation);
                              _ctrl.repeat();
                            }
                          },
                        ),
                    IconButton(
                      icon: Icon(
                        Icons.skip_next,
                        color: appBlack,
                        size: 50,
                      ),
                      onPressed: () {
                        _ctrl.stop();
                        val.playNext(val: val.selectedStation);
                        _ctrl.repeat();
                      },
                    ),
                  ],
                );
                  },
                )
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 30,
            right: 30,
            child: Consumer<PlayerState>(
              builder: (context, PlayerState val, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    BodyText(
                      val.selectedStation.name,
                      maxLines: 2,
                      color: appWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      alignment: TextAlign.center,
                    ),
                    BodyText(
                      val.selectedStation.genre,
                      maxLines: 2,
                      color: appWhite,
                      fontSize: 20,
                      alignment: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}