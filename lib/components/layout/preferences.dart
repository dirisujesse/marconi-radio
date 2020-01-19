import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/state/preferences.dart';
import 'package:marconi_radio/components/layout/station_list.dart';
import 'package:marconi_radio/components/state/app_error.dart';
import 'package:marconi_radio/components/state/app_spinner.dart';

class Preferences extends StatelessWidget {
  final bool isFav;

  Preferences(this.isFav);

  @override
  Widget build(BuildContext context) {
    final _playState = PlayerState.getInstance();
    return Consumer<PrefsState>(
      builder: (context, state, _) {
        return FutureBuilder(
          future: Future.wait([state.favourites, state.recent]),
          builder: (context, AsyncSnapshot<List<dynamic>> res) {
            if (res.hasData) {
              final List<dynamic> data = res.data[isFav ? 0 : 1];
              if (data.length == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.playlist_play, size: 60),
                      SizedBox(
                        height: 20,
                      ),
                      Text("${isFav ? 'Favourites' : 'Recent'} list is empty")
                    ],
                  ),
                );
              }
              _playState.stations = data;
              return StationList(
                data: data,
                favs: isFav ? data : res.data[0],
                ctx: context,
              );
            } else if (res.hasError) {
              return const AppError();
            } else {
              return const AppSpinner();
            }
          },
        );
      },
    );
  }
}
