import 'package:flutter/material.dart';
import 'package:marconi_radio/components/typography/app_txt.dart';
import 'package:marconi_radio/models/station.dart';
import 'package:marconi_radio/state/network.dart';
import 'package:marconi_radio/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:marconi_radio/state/player.dart';

class StationList extends StatelessWidget {
  final List<dynamic> data;
  final List<dynamic> favs;
  final BuildContext ctx;
  final bool isSearch;

  StationList({@required this.data, @required this.favs, @required this.ctx, this.isSearch = false});

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

  @override
  Widget build(BuildContext context) {
    final _playState = PlayerState.getInstance();
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 100),
      separatorBuilder: (context, idx) {
        if (idx != data.length - 1) {
          return Container(
            height: 0.8,
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: appGrey,
          );
        } else {
          return SizedBox();
        }
      },
      itemCount: data.length,
      itemBuilder: (context, idx) {
        final rawStation = data[idx];
        if (isSearch) {
          rawStation["logo"] = 'https://res.cloudinary.com/jesse-dirisu/image/upload/v1577453507/marconixl.png';
        }
        Station station =
            Station.fromJson(Map<String, dynamic>.from(rawStation));
        bool isFav = favs.any((it) => it["id"] == station.id);
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            backgroundImage: NetworkImage(
              station?.logo
            ),
          ),
          title: BodyText(
            station.name.toUpperCase(),
            maxLines: 1,
          ),
          subtitle: Text(station.genre),
          onTap: () {
            if (NetworkState.getInstance().isOffline) {
              _showSnack();
              return;
            }
            final stationId = _playState?.selectedStation?.id ?? "";
            if (stationId != station.id) {
              _playState.play(val: station);
            }
            Navigator.of(context).pushNamed('/detail');
          },
          trailing: Consumer2<PlayerState, NetworkState>(
            builder: (context, state, state2, _) {
              return PopupMenuButton<String>(
                padding: EdgeInsets.only(right: 0),
                icon: Icon(Icons.more_vert),
                onSelected: (val) {
                  switch (val) {
                    case "play":
                      if (state2.isOffline) {
                        _showSnack();
                        return;
                      }
                      state.play(val: station);
                      break;
                    case "pause":
                      state.pause();
                      break;
                    case "fav":
                      state.prefs.add(station);
                      break;
                    case "remove":
                      state.prefs.remove(station.id);
                      break;
                    default:
                      return;
                  }
                },
                itemBuilder: (context) {
                  final isActiveStation = state.isPlaying &&
                      (state.selectedStation.id == station.id);
                  return [
                    PopupMenuItem(
                      value: isActiveStation ? "pause" : "play",
                      child: Text(isActiveStation ? "Pause" : "Play"),
                    ),
                    PopupMenuItem(
                      value: isFav ? "remove" : "fav",
                      child: Text(
                          "${isFav ? "Remove from" : "Add to"} favourites"),
                    ),
                  ];
                },
              );
            },
          ),
        );
      },
    );
  }
}
