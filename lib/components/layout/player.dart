import 'package:flutter/material.dart';
import 'package:marconi_radio/components/fragments/play_button.dart';
import 'package:marconi_radio/components/state/app_spinner.dart';
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
  final AnimationController ctrl;
  MarconiPlayer(
    this.ctx, {
    this.playerType = PlayerType.BottomNavPlayer,
    this.station,
    this.ctrl,
  });

  _showSnack() {
    Scaffold.of(ctx).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content:
            Text("Please connect to the internet to use this functinality"),
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
          case PlayerType.FloatingPlayer:
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.skip_previous,
                    color: appBlack,
                    size: 50,
                  ),
                  onTap: () {
                    ctrl.stop();
                    _playPrev(conn, data);
                    ctrl.repeat();
                  },
                ),
                GestureDetector(
                  child: data.isLoading
                      ? const AppSpinner()
                      : Icon(
                          !data.isPlaying
                              ? Icons.play_circle_filled
                              : Icons.pause_circle_filled,
                          color: appBlack,
                          size: 50,
                        ),
                  onTap: () {
                    if (conn.isOffline) {
                      return _showSnack();
                    }
                    if (data.isPlaying) {
                      ctrl.stop();
                      data.pause();
                    } else {
                      data.play(val: data.selectedStation);
                      ctrl.repeat();
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
                    ctrl.stop();
                    _playNext(conn, data);
                    ctrl.repeat();
                  },
                ),
              ],
            );
            break;
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
                  onTap: () => Navigator.of(context).pushNamed('/detail'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      data?.selectedStation?.logo ??
                          'https://res.cloudinary.com/jesse-dirisu/image/upload/v1577453507/marconixl.png',
                    ),
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
