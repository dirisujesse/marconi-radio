import 'package:flutter/material.dart';
import 'package:marconi_radio/components/state/app_spinner.dart';
import 'package:marconi_radio/state/network.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/styles/colors.dart';

class PlayButton extends StatelessWidget {
  final PlayerState playerState;
  final NetworkState netState;
  final Function play;
  final bool isGetureDetector;

  PlayButton({
    @required this.playerState,
    @required this.play,
    @required this.netState,
    this.isGetureDetector = false,
  });

  @override
  Widget build(BuildContext context) {
    if (playerState.isLoading) {
      return const AppSpinner();
    } else {
      return IconButton(
        icon: Icon(
          playerState.isPlaying
              ? Icons.pause_circle_outline
              : Icons.play_circle_outline,
          size: 40,
          color: appBlack,
        ),
        onPressed: () => play(netState, playerState),
      );
    }
  }
}
