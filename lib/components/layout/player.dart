import 'package:flutter/material.dart';
import 'package:marconi_radio/components/animations/disk.dart';
import 'package:marconi_radio/components/fragments/play_button.dart';
import 'package:marconi_radio/models/station.dart';
import 'package:marconi_radio/state/network.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/styles/colors.dart';
import 'package:provider/provider.dart';

enum PlayerType { PlayButton, BottomNavPlayer, FloatingPlayer }

class MarconiPlayer extends StatelessWidget {
  final BuildContext ctx;
  final PlayerType playerType;
  final Station station;
  MarconiPlayer(
    this.ctx, {
    this.playerType = PlayerType.BottomNavPlayer,
    this.station,
  });

  _showSnack() {
    Scaffold.of(ctx).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content:
            Text("Please connect to the internet to use this functionality"),
        backgroundColor: appBlack,
      ),
    );
  }

  _playOrPause(NetworkState conn, PlayerState playerState,
      {AnimationController control}) {
    if (conn.isOffline) {
      _showSnack();
    } else {}
    playerState.isPlaying
        ? playerState.pause()
        : playerState.play(val: playerState.selectedStation);
  }

  _playNext(NetworkState conn, PlayerState data) {
    if (conn.isOffline) {
      _showSnack();
    } else {
      data.playNext(val: data.selectedStation);
    }
  }

  void _playPrev(NetworkState conn, PlayerState data) {
    if (conn.isOffline) {
      _showSnack();
    } else {
      data.playPrev(val: data.selectedStation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PlayerState, NetworkState>(
      builder: (context, PlayerState data, NetworkState conn, _) {
        switch (playerType) {
          case PlayerType.PlayButton:
            return IconButton(
              icon: Icon(
                (data.isPlaying && station.id == data.selectedStation.id)
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                size: 40,
                color: appBlack,
              ),
              onPressed: () {
                if (conn.isOffline) {
                  return _showSnack();
                }
                (data.isPlaying && station.id == data.selectedStation.id)
                    ? data.pause()
                    : data.play(val: station);
              },
            );
            break;
          default:
            if (data.selectedStation != null) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: appWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: appGrey,
                      blurRadius: 1.5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    if (playerType == PlayerType.FloatingPlayer) {
                      return;
                    }
                    Navigator.of(context).pushNamed('/detail');
                  },
                  leading: AppDisk(
                    data.selectedStation,
                    maxWidth: 50,
                  ),
                  title: Text(
                    data.selectedStation.name.toUpperCase(),
                    maxLines: 1,
                  ),
                  subtitle: Text(data.selectedStation.genre),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.skip_previous,
                          size: 40,
                          color: appBlack,
                        ),
                        onPressed: () {
                          _playPrev(conn, data);
                        },
                      ),
                      PlayButton(
                        playerState: data,
                        play: _playOrPause,
                        netState: conn,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.skip_next,
                          size: 40,
                          color: appBlack,
                        ),
                        onPressed: () {
                          _playNext(conn, data);
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
        }
      },
    );
  }
}
